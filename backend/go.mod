module github.com/umputun/remark/backend

go 1.12

replace gopkg.in/russross/blackfriday.v2 => github.com/russross/blackfriday/v2 v2.0.1

require (
	cloud.google.com/go v0.39.0 // indirect
	github.com/PuerkitoBio/goquery v1.5.0
	github.com/coreos/bbolt v1.3.2
	github.com/dgrijalva/jwt-go v3.2.0+incompatible
	github.com/didip/tollbooth v4.0.0+incompatible
	github.com/didip/tollbooth_chi v0.0.0-20170928041846-6ab5f3083f3d
	github.com/globalsign/mgo v0.0.0-20181015135952-eeefdecb41b8
	github.com/go-chi/chi v4.0.2+incompatible
	github.com/go-chi/cors v1.0.0
	github.com/go-chi/render v1.0.1
	github.com/go-pkgz/auth v0.5.2
	github.com/go-pkgz/lcw v0.3.1
	github.com/go-pkgz/lgr v0.6.2
	github.com/go-pkgz/mongo v1.1.2
	github.com/go-pkgz/repeater v1.1.2
	github.com/go-pkgz/rest v1.4.1
	github.com/go-pkgz/syncs v1.1.1
	github.com/golang/protobuf v1.3.1 // indirect
	github.com/google/uuid v1.1.1
	github.com/gorilla/feeds v1.1.1
	github.com/hashicorp/go-multierror v1.0.0
	github.com/hashicorp/golang-lru v0.5.1 // indirect
	github.com/jessevdk/go-flags v0.0.0-20180331124232-1c38ed7ad0cc
	github.com/microcosm-cc/bluemonday v1.0.2
	github.com/patrickmn/go-cache v2.1.0+incompatible
	github.com/pkg/errors v0.8.1
	github.com/rakyll/statik v0.1.6
	github.com/rs/xid v1.2.1
	github.com/shurcooL/sanitized_anchor_name v1.0.0 // indirect
	github.com/stretchr/objx v0.2.0 // indirect
	github.com/stretchr/testify v1.3.0
	go.etcd.io/bbolt v1.3.2 // indirect
	golang.org/x/crypto v0.0.0-20190530122614-20be4c3c3ed5
	golang.org/x/image v0.0.0-20190523035834-f03afa92d3ff
	golang.org/x/net v0.0.0-20190603091049-60506f45cf65
	golang.org/x/oauth2 v0.0.0-20190604053449-0f29369cfe45 // indirect
	golang.org/x/sys v0.0.0-20190602015325-4c4f7f33c9ed // indirect
	golang.org/x/text v0.3.2 // indirect
	golang.org/x/time v0.0.0-20190308202827-9d24e82272b4 // indirect
	google.golang.org/appengine v1.6.0 // indirect
	gopkg.in/russross/blackfriday.v2 v2.0.0-00010101000000-000000000000
)
