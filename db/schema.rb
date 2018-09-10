# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_03_031812) do

  create_table "beneficiaries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "rid", limit: 13, null: false
    t.string "uid", limit: 12, null: false
    t.string "full_name", null: false
    t.string "address", null: false
    t.string "country", null: false
    t.string "currency", null: false
    t.string "account_number", null: false
    t.string "account_type", null: false
    t.string "bank_name", null: false
    t.string "bank_address", null: false
    t.string "bank_country", null: false
    t.string "bank_swift_code"
    t.string "intermediary_bank_name"
    t.string "intermediary_bank_address"
    t.string "intermediary_bank_country"
    t.string "intermediary_bank_swift_code"
    t.string "status", default: "approved", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rid"], name: "index_beneficiaries_on_rid", unique: true
    t.index ["uid"], name: "index_beneficiaries_on_uid"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 40
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["body"], name: "index_messages_on_body", unique: true
    t.index ["title"], name: "index_messages_on_title", unique: true
  end

  create_table "tiers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "color", limit: 10, null: false
    t.string "name", limit: 30, null: false
    t.integer "min_holding", null: false
    t.integer "fee_discount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["min_holding"], name: "index_tiers_on_min_holding", unique: true
    t.index ["name"], name: "index_tiers_on_name", unique: true
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.string "uid", limit: 14, null: false
    t.integer "level", limit: 1, default: 0, null: false
    t.string "state", limit: 30, default: "pending", null: false
    t.boolean "fee_payment_in_bcio_token", default: false, null: false
    t.integer "custom_withdrawal_limit", default: 0, null: false
    t.bigint "referrer_id"
    t.string "referral_code", limit: 32
    t.string "options", limit: 1000, default: "{}", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true
    t.index ["referrer_id"], name: "index_users_on_referrer_id"
    t.index ["state"], name: "index_users_on_state"
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "users", "users", column: "referrer_id"
end
