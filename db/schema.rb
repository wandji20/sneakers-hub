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

ActiveRecord::Schema.define(version: 2022_01_03_073427) do

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_brands_on_name"
  end

  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_genders_on_name"
  end

  create_table "sneakers", force: :cascade do |t|
    t.integer "brand_id", null: false
    t.integer "gender_id", null: false
    t.string "colors"
    t.date "release_date"
    t.integer "price"
    t.string "shoe_id"
    t.string "title"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"name\"", name: "index_sneakers_on_name"
    t.index ["brand_id"], name: "index_sneakers_on_brand_id"
    t.index ["gender_id"], name: "index_sneakers_on_gender_id"
    t.index ["shoe_id"], name: "index_sneakers_on_shoe_id"
  end

  add_foreign_key "sneakers", "brands"
  add_foreign_key "sneakers", "genders"
end
