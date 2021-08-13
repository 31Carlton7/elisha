package genre

import (
	"github.com/rkeplin/bible-go-api/core"
)

var handler = Handler{}

func AddRoutes() {
	routes := core.NewRoutes()

	routes.Add(core.Route{
		Name:        "FindAll",
		Method:      "GET",
		Pattern:     "/genres",
		HandlerFunc: handler.FindAll,
	})

	routes.Add(core.Route{
		Name:        "FindOne",
		Method:      "GET",
		Pattern:     "/genres/{id}",
		HandlerFunc: handler.FindOne,
	})
}
