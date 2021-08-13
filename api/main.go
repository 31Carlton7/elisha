package main

import (
	"log"
	"net/http"

	"github.com/rkeplin/bible-go-api/book"
	"github.com/rkeplin/bible-go-api/core"
	"github.com/rkeplin/bible-go-api/genre"
	"github.com/rkeplin/bible-go-api/relations"
	"github.com/rkeplin/bible-go-api/text"
	"github.com/rkeplin/bible-go-api/translation"
	"github.com/rkeplin/bible-go-api/search"
)

func main() {
	relations.AddRoutes()
	text.AddRoutes()
	book.AddRoutes()
	genre.AddRoutes()
	translation.AddRoutes()
	search.AddRoutes()

	router := core.NewRouter()

	log.Fatal(http.ListenAndServe(":3000", router))
}
