package relations

type Book struct {
	ID        int64  `json:"id"`
	Name      string `json:"name"`
	Testament string `json:"testament"`
}

type Text struct {
	ID                 int64  `json:"id"`
	Book               Book   `json:"book"`
	ChapterID          int64  `json:"chapterId"`
	VerseID            int64  `json:"verseId"`
	Verse              string `json:"verse"`
	RelationStartVerse int    `json:"relationStartVerse"`
	RelationEndVerse   int    `json:"relationEndVerse"`
	Group              int    `json:"group,omitempty"`
	Rank               int    `json:"rank"`
}

type TextCollection []Text
