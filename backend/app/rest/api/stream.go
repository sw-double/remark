package api

import (
	"context"
	"io"
	"net/http"
	"sync/atomic"
	"time"

	log "github.com/go-pkgz/lgr"
	"github.com/pkg/errors"
)

// Streamer creates endless stream of \n separated json records send to remote client
type Streamer struct {
	TimeOut   time.Duration
	Refresh   time.Duration
	MaxActive int32

	activeCount int32
}

type steamEventFn func() (data []byte, upd bool, err error)

type steamEventResp struct {
	data []byte
	err  error
}

// Activate starts blocking function streaming update created by eventFn to ResponseWriter
// canceled on context or inactivity timeout
// note: eventFn is a closure needed to allow state management inside eventFn
func (s *Streamer) Activate(ctx context.Context, eventFn func() steamEventFn, w io.Writer) error {
	updCh := s.eventsCh(ctx, eventFn())

	count := atomic.AddInt32(&s.activeCount, 1)
	defer atomic.AddInt32(&s.activeCount, -1)
	if count > s.MaxActive {
		return errors.New("too many streams")
	}

	for {
		select {
		case <-ctx.Done(): // request closed by remote client
			log.Printf("[DEBUG] stream closed by remote client, %s", ctx.Err())
			return nil
		case <-time.After(s.TimeOut): // request closed by timeout
			log.Printf("[DEBUG] stream closed due to timeout")
			return nil
		case resp, ok := <-updCh: // new update
			if !ok { // closed updCh
				return nil
			}
			if resp.err != nil {
				return resp.err
			}
			if _, e := w.Write(resp.data); e != nil {
				return errors.Wrap(e, "send to stream failed")
			}
			if fw, okFlush := w.(http.Flusher); okFlush {
				fw.Flush()
			}
		}
	}
}

// populate updates to chan, break on context close
func (s *Streamer) eventsCh(ctx context.Context, fn steamEventFn) <-chan steamEventResp {
	ch := make(chan steamEventResp)
	go func() {
		tick := time.NewTicker(s.Refresh)
		defer func() {
			close(ch)
			tick.Stop()
		}()
		for {
			select {
			case <-ctx.Done(): // request closed by remote client
				return
			case <-tick.C:
				resp, upd, err := fn()
				if err != nil {
					ch <- steamEventResp{data: nil, err: errors.Wrap(err, "can't get stream data")}
					return
				}
				if upd {
					ch <- steamEventResp{data: resp, err: nil}
				}
			}
		}
	}()
	return ch
}
