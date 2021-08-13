package book

import (
	"github.com/rkeplin/bible-go-api/core"
)

var handler = Handler{}

func AddRoutes() {
	routes := core.NewRoutes()

	routes.Add(core.Route{
		Name:        "FindAll",
		Method:      "GET",
		Pattern:     "/books",
		HandlerFunc: handler.FindAll,
	})

	routes.Add(core.Route{
		Name:        "FindOne",
		Method:      "GET",
		Pattern:     "/books/{id}",
		HandlerFunc: handler.FindOne,
	})

	routes.Add(core.Route{
		Name:        "FindChapters",
		Method:      "GET",
		Pattern:     "/books/{id}/chapters",
		HandlerFunc: handler.FindChapters,
	})
}
