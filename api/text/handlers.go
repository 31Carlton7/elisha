package text

import (
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
	"github.com/rkeplin/bible-go-api/core"
)

type Handler struct {
	repo Repository
}

func (h Handler) FindAllFromChapter(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	bookId, err := strconv.Atoi(vars["bookId"])

	if err != nil {
		panic(err)
	}

	chapterId, err := strconv.Atoi(vars["chapterId"])

	if err != nil {
		panic(err)
	}

	queryParams := r.URL.Query()
	translation := queryParams.Get("translation")

	collection, err := h.repo.FindAll(bookId, chapterId, translation)

	if err != nil {
		panic(err)
	}

	core.Respond(w, http.StatusOK, collection)
}

func (h Handler) FindOne(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	verseId, err := strconv.Atoi(vars["verseId"])

	if err != nil {
		panic(err)
	}

	queryParams := r.URL.Query()
	translation := queryParams.Get("translation")

	item, err := h.repo.FindOne(verseId, translation)

	if err != nil {
		response := core.HttpErrorResponse{
			Code:    404,
			Status:  "Not Found",
			Message: "Item was not found.",
		}

		core.Respond(w, http.StatusNotFound, response)

		return
	}

	core.Respond(w, http.StatusOK, item)
}
