package core

import (
	"net/http"
)

type Route struct {
	Name        string
	Method      string
	Pattern     string
	HandlerFunc http.HandlerFunc
}

type Routes struct {
	routes []Route
}

func (r *Routes) Add(route Route) {
	r.routes = append(r.routes, route)
}

func (r *Routes) GetAll() []Route {
	return r.routes
}

func NewRoutes() *Routes {
	return &routes
}

var routes = Routes{}
