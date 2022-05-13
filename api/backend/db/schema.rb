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

ActiveRecord::Schema[7.0].define(version: 2022_05_12_121203) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.bigint "picture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["picture_id"], name: "index_albums_on_picture_id"
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "albums_pictures", force: :cascade do |t|
    t.bigint "picture_id"
    t.bigint "album_id"
    t.index ["album_id"], name: "index_albums_pictures_on_album_id"
    t.index ["picture_id"], name: "index_albums_pictures_on_picture_id"
  end

  create_table "albums_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "album_id"
    t.index ["album_id"], name: "index_albums_users_on_album_id"
    t.index ["user_id"], name: "index_albums_users_on_user_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "pseudo"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "unique_emails", unique: true
  end

end
