package genre

type Genre struct {
	ID   int64  `json:"id"`
	Name string `json:"name"`
}

type GenreCollection []Genre
