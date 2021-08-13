package text

import (
	"fmt"

	"github.com/rkeplin/bible-go-api/common"
	"github.com/rkeplin/bible-go-api/core"
)

type Repository struct {
	translationFactory common.TranslationFactory
}

func (r Repository) FindAll(bookId int, chapterId int, translation string) (TextCollection, error) {
	core.WaitForDb()

	collection := TextCollection{}

	table := r.translationFactory.GetTable(translation)

	statement := fmt.Sprintf("SELECT t.id, t.chapterId, t.verseId, t.verse, b.id, b.name, b.testament FROM %s t INNER JOIN books b ON t.bookId = b.id WHERE t.bookId = ? AND t.chapterId = ? ORDER BY t.id ASC", table)
	rows, err := core.DB.Query(statement, bookId, chapterId)

	defer rows.Close()

	if err != nil {
		return collection, err
	}

	var t Text

	for rows.Next() {

		if err := rows.Scan(&t.ID, &t.ChapterID, &t.VerseID, &t.Verse, &t.Book.ID, &t.Book.Name, &t.Book.Testament); err != nil {
			return collection, err
		}

		collection = append(collection, t)
	}

	return collection, nil
}

func (r Repository) FindOne(id int, translation string) (Text, error) {
	core.WaitForDb()

	var t Text

	table := r.translationFactory.GetTable(translation)

	statement := fmt.Sprintf("SELECT t.id, t.chapterId, t.verseId, t.verse, b.id, b.name, b.testament FROM %s t INNER JOIN books b ON t.bookId = b.id WHERE t.id = ?", table)
	err := core.DB.QueryRow(statement, id).Scan(&t.ID, &t.ChapterID, &t.VerseID, &t.Verse, &t.Book.ID, &t.Book.Name, &t.Book.Testament)

	if err != nil {
		return t, err
	}

	return t, nil
}
