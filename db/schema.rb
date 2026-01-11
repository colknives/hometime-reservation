# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_01_11_175359) do
  create_table "guests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index "lower(email)", name: "index_guests_on_lower_email", unique: true
    t.index ["email"], name: "index_guests_on_email"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "adults"
    t.integer "children"
    t.datetime "created_at", null: false
    t.string "currency"
    t.date "end_date"
    t.integer "guest_id", null: false
    t.integer "guests"
    t.integer "infants"
    t.integer "nights"
    t.decimal "payout_price"
    t.decimal "security_price"
    t.date "start_date"
    t.string "status"
    t.decimal "total_price"
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
  end

  add_foreign_key "reservations", "guests"
end
