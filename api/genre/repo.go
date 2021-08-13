package genre

import (
	"github.com/rkeplin/bible-go-api/core"
)

type Repository struct{}

func (r Repository) FindAll() (GenreCollection, error) {
	core.WaitForDb()

	collection := GenreCollection{}

	statement := "SELECT id, name FROM genres ORDER BY id ASC"
	rows, err := core.DB.Query(statement)

	defer rows.Close()

	if err != nil {
		return collection, err
	}

	var g Genre

	for rows.Next() {

		if err := rows.Scan(&g.ID, &g.Name); err != nil {
			return collection, err
		}

		collection = append(collection, g)
	}

	return collection, nil
}

func (r Repository) FindOne(id int) (Genre, error) {
	core.WaitForDb()

	var g Genre

	statement := "SELECT id, name FROM genres WHERE id = ?"
	err := core.DB.QueryRow(statement, id).Scan(&g.ID, &g.Name)

	if err != nil {
		return g, err
	}

	return g, nil
}
