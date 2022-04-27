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

ActiveRecord::Schema[7.0].define(version: 2022_04_26_212622) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "location_features", force: :cascade do |t|
    t.bigint "survivor_id", null: false
    t.bigint "nearest_survivor_id"
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nearest_survivor_id"], name: "index_location_features_on_nearest_survivor_id"
    t.index ["survivor_id", "latitude", "longitude"], name: "index_location_features_on_survivor_id_and_location"
    t.index ["survivor_id"], name: "index_location_features_on_survivor_id"
  end

  create_table "records", force: :cascade do |t|
    t.bigint "survivor_id", null: false
    t.bigint "by_survivor_id"
    t.integer "kind", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["by_survivor_id"], name: "index_records_on_by_survivor_id"
    t.index ["survivor_id"], name: "index_records_on_survivor_id"
  end

  create_table "survivors", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.integer "gender", null: false
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_survivors_on_name"
  end

  add_foreign_key "location_features", "survivors"
  add_foreign_key "records", "survivors"
end
