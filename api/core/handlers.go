package core

import (
	"encoding/json"
	"net/http"
)

func Respond(w http.ResponseWriter, status int, v interface{}) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(status)

	err := json.NewEncoder(w).Encode(v)

	if err != nil {
		panic(err)
	}
}
