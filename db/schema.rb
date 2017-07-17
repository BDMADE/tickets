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

ActiveRecord::Schema.define(version: 20170716121455) do

  create_table "permissions", force: :cascade do |t|
    t.integer "user_type_id"
    t.boolean "dashboard"
    t.boolean "usertype"
    t.boolean "ticket"
    t.boolean "user"
    t.boolean "add"
    t.boolean "edit"
    t.boolean "remove_ability"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_type_id"], name: "index_permissions_on_user_type_id"
  end

  create_table "ticket_replies", force: :cascade do |t|
    t.text "description"
    t.integer "user_id"
    t.integer "ticket_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_ticket_replies_on_ticket_id"
    t.index ["user_id"], name: "index_ticket_replies_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "subject"
    t.text "message"
    t.integer "status_type"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "user_types", force: :cascade do |t|
    t.string "name"
    t.boolean "published"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "email"
    t.string "ip_address"
    t.boolean "published", default: false
    t.string "profession"
    t.string "phone"
    t.integer "user_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["user_type_id"], name: "index_users_on_user_type_id"
  end

end
