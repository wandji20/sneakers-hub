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

ActiveRecord::Schema.define(version: 2022_07_30_124210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "sneaker_id"
    t.float "sub_total"
    t.integer "quantity", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "shopping_cart_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["shopping_cart_id"], name: "index_order_items_on_shopping_cart_id"
    t.index ["sneaker_id"], name: "index_order_items_on_sneaker_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.string "payment_intent_id"
    t.string "payment_intent_client_id"
    t.integer "status", default: 0
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_shopping_carts_on_user_id"
  end

  create_table "sneakers", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.bigint "gender_id", null: false
    t.string "colors"
    t.string "name"
    t.date "release_date"
    t.integer "price"
    t.string "shoe_id"
    t.string "title"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_sneakers_on_brand_id"
    t.index ["gender_id"], name: "index_sneakers_on_gender_id"
    t.index ["name"], name: "index_sneakers_on_name"
    t.index ["shoe_id"], name: "index_sneakers_on_shoe_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "sneakers"
  add_foreign_key "shopping_carts", "users"
  add_foreign_key "sneakers", "brands"
  add_foreign_key "sneakers", "genders"
end
