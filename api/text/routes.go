package text

import (
	"github.com/rkeplin/bible-go-api/core"
)

var handler = Handler{}

func AddRoutes() {
	routes := core.NewRoutes()

	routes.Add(core.Route{
		Name:        "FindAllFromChapter",
		Method:      "GET",
		Pattern:     "/books/{bookId}/chapters/{chapterId}",
		HandlerFunc: handler.FindAllFromChapter,
	})

	routes.Add(core.Route{
		Name:        "FindOne",
		Method:      "GET",
		Pattern:     "/books/{bookId}/chapters/{chapterId}/{verseId}",
		HandlerFunc: handler.FindOne,
	})
}
