# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140804110843) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "statements", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "upvotes"
    t.integer  "downvotes"
    t.integer  "rank"
    t.integer  "parent_id"
    t.boolean  "draft"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "statements", ["user_id"], name: "index_statements_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "ooth_id"
    t.string   "ooth_source"
    t.boolean  "incognito"
    t.text     "bio"
    t.string   "permissions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "social_info"
  end

end
