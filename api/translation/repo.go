package translation

import (
	"github.com/rkeplin/bible-go-api/core"
)

type Repository struct{}

func (r Repository) FindAll() (TranslationCollection, error) {
	core.WaitForDb()

	collection := TranslationCollection{}

	statement := "SELECT id, `table`, abbreviation, language, version, infoUrl FROM translations ORDER BY version ASC"
	rows, err := core.DB.Query(statement)

	defer rows.Close()

	if err != nil {
		return collection, err
	}

	var t Translation

	for rows.Next() {

		if err := rows.Scan(&t.ID, &t.Table, &t.Abbreviation, &t.Language, &t.Version, &t.InfoURL); err != nil {
			return collection, err
		}

		// Skipping this translation for now, some data is missing from it
		if t.Abbreviation == "WBT" {
			continue;
		}

		collection = append(collection, t)
	}

	return collection, nil
}

func (r Repository) FindOne(id int) (Translation, error) {
	core.WaitForDb()

	var t Translation

	statement := "SELECT id, `table`, abbreviation, language, version, infoUrl FROM translations WHERE id = ?"
	err := core.DB.QueryRow(statement, id).Scan(&t.ID, &t.Table, &t.Abbreviation, &t.Language, &t.Version, &t.InfoURL)

	if err != nil {
		return t, err
	}

	return t, nil
}
