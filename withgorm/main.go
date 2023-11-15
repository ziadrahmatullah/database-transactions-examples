package main

import (
	"log"
	"os"

	"github.com/shopspring/decimal"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type Account struct {
	Name    string          `gorm:"column:account_name"`
	Balance decimal.Decimal `gorm:"column:account_name"`
}

func main() {
	db, err := gorm.Open(postgres.Open(os.Getenv("DATABASE_URL")), &gorm.Config{})
	if err != nil {
		log.Fatalf("error opening connection to the database")
	}

	err = db.Transaction(func(tx *gorm.DB) error {
		if err := tx.Model(&Account{}).Where("account_name", "Alice").Update("balance", gorm.Expr("balance + 100")).Error; err != nil {
			return err
		}

		if err := tx.Model(&Account{}).Where("account_name", "Bob").Update("balance", gorm.Expr("balance - 100")).Error; err != nil {
			return err
		}

		return nil
	})
	if err != nil {
		log.Fatalf("error when executing the transaction")
	}

	// or manually

	tx := db.Begin()
	defer func() {
		if r := recover(); r != nil {
			tx.Rollback()
		}
	}()

	if err := tx.Error; err != nil {
		log.Fatalf("error to begin the transaction")
	}

	if err := tx.Model(&Account{}).Where("account_name", "Alice").Update("balance", gorm.Expr("balance + 100")).Error; err != nil {
		tx.Rollback()
		log.Fatalf("error when updating Alice's account")
	}

	if err := tx.Model(&Account{}).Where("account_name", "Bob").Update("balance", gorm.Expr("balance - 100")).Error; err != nil {
		tx.Rollback()
		log.Fatalf("error when updating Bob's account")
	}

	if err := tx.Commit().Error; err != nil {
		log.Fatalf("error to commit the transaction")
	}
}
