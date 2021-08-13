package relations

import (
	"github.com/rkeplin/bible-go-api/core"
)

var handler = Handler{}

func AddRoutes() {
	routes := core.NewRoutes()

	routes.Add(core.Route{
		Name:        "FindAll",
		Method:      "GET",
		Pattern:     "/verse/{id}/relations",
		HandlerFunc: handler.FindAll,
	})
}
