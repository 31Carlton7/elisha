package search

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strconv"

	"github.com/rkeplin/bible-go-api/book"
	"github.com/rkeplin/bible-go-api/common"
)

type Repository struct {
	translationFactory common.TranslationFactory
	bookRepo           book.Repository
}

func (r Repository) Search(query, translation string, offset, limit int) (TextCollection, error) {
	collection := TextCollection{}

	result, err := r.makeSearchRequest(query, translation, offset, limit)

	if err != nil {
		return collection, err
	}

	collection.Total = result.Hits.Total.Value

	for _, innerHit := range result.Hits.Hits {
		b := Book{
			ID:        innerHit.Source.BookID,
			Name:      innerHit.Source.BookName,
			Testament: innerHit.Source.Testament,
		}

		t := Text{
			ID:        innerHit.Source.ID,
			Book:      b,
			ChapterID: innerHit.Source.ChapterID,
			VerseID:   innerHit.Source.VerseID,
			Verse:     innerHit.Highlight.Verse[0],
		}

		collection.Items = append(collection.Items, t)
	}

	return collection, nil
}

func (r Repository) SearchAggregator(query, translation string) ([]SearchAggregation, error) {
	collection := []SearchAggregation{}

	result, err := r.makeSearchAggregationRequest(query, translation)

	if err != nil {
		return collection, err
	}

	books, err := r.bookRepo.FindAll()

	if err != nil {
		return collection, err
	}

	for _, book := range books {
		b := Book{}
		b.ID = book.ID
		b.Name = book.Name
		b.Testament = book.Testament

		s := SearchAggregation{
			Book: b,
			Hits: 0,
		}

		for _, bucket := range result.Aggregations.HitsPerBook.Buckets {
			if bucket.Key == book.ID {
				s.Hits = bucket.Count
				break
			}
		}

		collection = append(collection, s)
	}

	return collection, nil
}

func (r Repository) makeSearchRequest(query, translation string, offset, limit int) (ESResult, error) {
	esQueryStr := r.getESSearchQuery(query, offset, limit)

	return r.makeRequest(esQueryStr, translation)
}

func (r Repository) makeSearchAggregationRequest(query, translation string) (ESResult, error) {
	esQueryStr := r.getESSearchAggregationQuery(query)

	return r.makeRequest(esQueryStr, translation)
}

func (r Repository) makeRequest(esQueryStr, translation string) (ESResult, error) {
	result := ESResult{}
	index := r.translationFactory.GetIndex(translation)

	url := os.Getenv("ES_URL") + "/" + index + "/_search"

	fmt.Println("ES URL: ", url)
	fmt.Println("ES Query: ", esQueryStr)

	var jsonStr = []byte(esQueryStr)

	req, err := http.NewRequest("GET", url, bytes.NewBuffer(jsonStr))
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)

	defer resp.Body.Close()

	if err != nil {
		return result, err
	}

	if resp.StatusCode != 200 {
		return result, errors.New("Non-200 Response From ES")
	}

	body, _ := ioutil.ReadAll(resp.Body)

	json.Unmarshal(body, &result)

	return result, nil
}

func (r Repository) getESSearchAggregationQuery(query string) string {
	ESQuery := `{
		"size": 0,
		"query" : { "match" : { "verse" : "` + query + `" } },
		"aggs" : {
			"hitsPerBook" : { "terms" : { "field" : "bookId", "size": 100, "min_doc_count" : 0 } }
		}
	}`

	return ESQuery
}

func (r Repository) getESSearchQuery(query string, offset, limit int) string {
	if offset < 0 {
		offset = 0
	}

	if limit == 0 {
		limit = 100
	}

	if limit > 1000 {
		limit = 1000
	}

	ESQuery := `{
		"from":` + strconv.Itoa(offset) + `,
		"size":` + strconv.Itoa(limit) + `,
		"query": {
			"match": {
				"verse":"` + query + `"
			}
		},
		"highlight":{
			"pre_tags": ["<span class=\"highlight\">"],
			"post_tags":["</span>"],
			"fields": {
				"verse": {
					"type": "plain"
				}
			}
		}
	}`

	return ESQuery
}
