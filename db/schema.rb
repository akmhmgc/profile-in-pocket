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

ActiveRecord::Schema[7.0].define(version: 2023_07_28_132532) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issued_urls", force: :cascade do |t|
    t.string "url_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name", null: false, comment: "名前"
    t.text "description", null: false, comment: "自己紹介文"
    t.string "twitter_id", comment: "Twitter ID"
    t.string "github_id", comment: "GitHub ID"
    t.string "qiita_id", comment: "Qiita ID"
    t.string "zenn_id", comment: "Zenn ID"
    t.string "url", comment: "URL"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "issued_url_id"
    t.index ["issued_url_id"], name: "index_users_on_issued_url_id"
  end

  add_foreign_key "profiles", "users"
  add_foreign_key "users", "issued_urls"
end
