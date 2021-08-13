package core

import (
	"database/sql"
	"fmt"
	"log"
	"os"
	"time"

	_ "github.com/go-sql-driver/mysql" // Driver to database/sql
)

var DB *sql.DB

func init() {
	connectionString := fmt.Sprintf(
		"%s:%s@tcp(%s:3306)/%s?parseTime=true",
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASS"),
		os.Getenv("DB_HOST"),
		os.Getenv("DB_NAME"),
	)

	var err error

	DB, err = sql.Open("mysql", connectionString)

	if err != nil {
		log.Fatal(err)
	}

	DB.SetConnMaxLifetime(time.Hour)
	DB.SetMaxOpenConns(5)
	DB.SetMaxIdleConns(4)
}

func WaitForDb() {
	var err error

	maxRetries := 30

	for i := 0; i < maxRetries; i++ {
		err = DB.Ping()

		if err == nil {
			break
		}

		if err != nil {
			log.Print("Waiting for DB connection...")

			time.Sleep(2 * time.Second)
		}
	}
}
