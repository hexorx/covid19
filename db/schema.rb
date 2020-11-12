# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_11_120607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reports", force: :cascade do |t|
    t.integer "date", null: false
    t.string "state_id"
    t.integer "deaths"
    t.integer "hospitalized"
    t.integer "positive"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id", "date"], name: "index_reports_on_state_id_and_date", unique: true
    t.index ["state_id"], name: "index_reports_on_state_id"
  end

  create_table "states", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "notes"
    t.string "site"
    t.string "twitter"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_states_on_code", unique: true
  end

  add_foreign_key "reports", "states", primary_key: "code"
end
