package genre

import (
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
	"github.com/rkeplin/bible-go-api/core"
)

type Handler struct {
	repo Repository
}

func (h Handler) FindAll(w http.ResponseWriter, r *http.Request) {
	collection, err := h.repo.FindAll()

	if err != nil {
		panic(err)
	}

	core.Respond(w, http.StatusOK, collection)
}

func (h Handler) FindOne(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])

	if err != nil {
		panic(err)
	}

	item, err := h.repo.FindOne(id)

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
