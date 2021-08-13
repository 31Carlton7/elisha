package relations

import (
	"fmt"

	"github.com/rkeplin/bible-go-api/common"
	"github.com/rkeplin/bible-go-api/core"
)

type Repository struct {
	translationFactory common.TranslationFactory
}

func (r Repository) FindAll(verseId int, translation string) ([]TextCollection, error) {
	core.WaitForDb()

	collection := []TextCollection{}

	relations, err := r.fetchAllRelations(verseId, translation)

	if err != nil {
		return collection, err
	}

	for _, item := range relations {
		if item.RelationEndVerse == 0 {
			groupedCollection := TextCollection{item}

			collection = append(collection, groupedCollection)

			continue
		}

		groupedCollection, err := r.fetchGroupedRelations(item.RelationStartVerse, item.RelationEndVerse, translation)

		if err != nil {
			return collection, err
		}

		for _, groupedItem := range groupedCollection {
			groupedItem.Group = item.RelationStartVerse
		}

		collection = append(collection, groupedCollection)
	}

	return collection, nil
}

func (r Repository) fetchAllRelations(verseId int, translation string) (TextCollection, error) {
	table := r.translationFactory.GetTable(translation)

	collection := TextCollection{}

	statement := fmt.Sprintf("SELECT t.id, t.chapterId, t.verseId, t.verse, b.id, b.name, b.testament, r.startVerse, r.endVerse, r.rank FROM relations r INNER JOIN %s t ON r.startVerse = t.id INNER JOIN books b ON t.bookId = b.id WHERE r.verseId = ? ORDER BY r.rank ASC", table)
	rows, err := core.DB.Query(statement, verseId)

	defer rows.Close()

	if err != nil {
		return collection, err
	}

	var t Text

	for rows.Next() {

		if err := rows.Scan(&t.ID, &t.ChapterID, &t.VerseID, &t.Verse, &t.Book.ID, &t.Book.Name, &t.Book.Testament, &t.RelationStartVerse, &t.RelationEndVerse, &t.Rank); err != nil {
			return collection, err
		}

		if t.Book.Testament == "OT" {
			t.Book.Testament = "Old Testament"
		} else {
			t.Book.Testament = "New Testament"
		}

		collection = append(collection, t)
	}

	return collection, nil
}

func (r Repository) fetchGroupedRelations(startVerse int, endVerse int, translation string) (TextCollection, error) {
	table := r.translationFactory.GetTable(translation)

	collection := TextCollection{}

	statement := fmt.Sprintf("SELECT t.id, t.chapterId, t.verseId, t.verse, b.id, b.name, b.testament FROM %s t INNER JOIN books b ON t.bookId = b.id WHERE t.id BETWEEN ? AND ? ORDER BY t.id ASC", table)
	rows, err := core.DB.Query(statement, startVerse, endVerse)

	defer rows.Close()

	if err != nil {
		return collection, err
	}

	var t Text

	for rows.Next() {

		if err := rows.Scan(&t.ID, &t.ChapterID, &t.VerseID, &t.Verse, &t.Book.ID, &t.Book.Name, &t.Book.Testament); err != nil {
			return collection, err
		}

		if t.Book.Testament == "OT" {
			t.Book.Testament = "Old Testament"
		} else {
			t.Book.Testament = "New Testament"
		}

		t.RelationStartVerse = startVerse
		t.RelationEndVerse = endVerse

		collection = append(collection, t)
	}

	return collection, nil
}
