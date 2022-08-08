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

ActiveRecord::Schema[7.0].define(version: 2022_08_08_195443) do
  create_table "events", force: :cascade do |t|
    t.string "location"
    t.text "description"
    t.datetime "start_time", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "host_id"
    t.string "title"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "attending", default: "no response"
    t.integer "host_id"
    t.integer "invitee_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitee_id", "event_id"], name: "index_invitations_on_invitee_id_and_event_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "auth_token"
    t.string "status", default: "offline"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
