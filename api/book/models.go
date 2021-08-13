package book

type Book struct {
	ID        int64  `json:"id"`
	Name      string `json:"name"`
	Testament string `json:"testament"`
	Genre     Genre  `json:"genre"`
}

type BookCollection []Book

type Genre struct {
	ID   int64  `json:"id"`
	Name string `json:"name"`
}

type Chapter struct {
	ID int64 `json:"id"`
}

type ChapterCollection []Chapter
