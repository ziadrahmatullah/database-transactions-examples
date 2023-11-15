package main

import (
	"database/sql"
	"log"
	"os"

	_ "github.com/jackc/pgx/v5/stdlib"
)

func main() {
	db, err := sql.Open("pgx", os.Getenv("DATABASE_URL"))
	if err != nil {
		log.Fatalf("error opening connection: %v", err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		log.Fatalf("error ping to the database: %v", err)
	}

	tx, err := db.Begin()
	if err != nil {
		log.Fatalf("error to begin the transaction: %v", err)
	}
	defer tx.Rollback()

	sql := "UPDATE accounts SET balance = balance + 100 WHERE account_name = 'Alice'"
	_, err = tx.Exec(sql)
	if err != nil {
		log.Fatalf("error update Alice's data: %v", err)
	}

	sql = "UPDATE accounts SET balance = balance - 100 WHERE account_name = 'Bob'"
	_, err = tx.Exec(sql)
	if err != nil {
		log.Fatalf("error update Bob's data: %v", err)
	}

	err = tx.Commit()
	if err != nil {
		log.Fatalf("error to commit the transaction: %v", err)
	}

	log.Println("The funds transfer from Alice's to Bob's account is successful")
}
