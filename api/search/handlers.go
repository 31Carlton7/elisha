package search

import (
	"net/http"
	"strconv"

	"github.com/rkeplin/bible-go-api/core"
)

type Handler struct {
	repo Repository
}

func (h Handler) Search(w http.ResponseWriter, r *http.Request) {
	queryParams := r.URL.Query()
	query := queryParams.Get("query")
	translation := queryParams.Get("translation")

	offset, err := strconv.Atoi(queryParams.Get("offset"))

	if err != nil {
		offset = 0
	}

	limit, err := strconv.Atoi(queryParams.Get("limit"))

	if err != nil {
		limit = 100
	}

	collection, err := h.repo.Search(query, translation, offset, limit)

	if err != nil {
		response := core.HttpErrorResponse{
			Code:    400,
			Status:  "Bad Request",
			Message: "An error has occurred while searching.",
		}

		core.Respond(w, http.StatusBadRequest, response)

		return
	}

	core.Respond(w, http.StatusOK, collection)
}

func (h Handler) SearchAggregator(w http.ResponseWriter, r *http.Request) {
	queryParams := r.URL.Query()
	query := queryParams.Get("query")
	translation := queryParams.Get("translation")

	collection, err := h.repo.SearchAggregator(query, translation)

	if err != nil {
		response := core.HttpErrorResponse{
			Code:    400,
			Status:  "Bad Request",
			Message: "An error has occurred while aggregating search.",
		}

		core.Respond(w, http.StatusBadRequest, response)

		return
	}

	core.Respond(w, http.StatusOK, collection)
}