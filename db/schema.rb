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

ActiveRecord::Schema[8.1].define(version: 2026_09_11_080821) do
  create_table "consultations", force: :cascade do |t|
    t.string "budget_range"
    t.datetime "created_at", null: false
    t.string "device_type"
    t.string "mobility"
    t.string "priority"
    t.datetime "updated_at", null: false
    t.string "usage_type"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_consultations_on_user_id"
  end

  create_table "generated_contents", force: :cascade do |t|
    t.string "content_type"
    t.datetime "created_at", null: false
    t.integer "product_id", null: false
    t.text "prompt"
    t.text "response"
    t.string "services"
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_generated_contents_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "image_url"
    t.string "name"
    t.decimal "price"
    t.text "sales_argument"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consultations", "users"
  add_foreign_key "generated_contents", "products"
end
