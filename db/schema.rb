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

ActiveRecord::Schema.define(version: 20130717100547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: true do |t|
    t.string   "image"
    t.string   "title"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title",                              null: false
    t.text     "content",                            null: false
    t.datetime "published_at"
    t.string   "status",           default: "draft", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "intro"
    t.string   "slug"
    t.string   "html_title"
    t.string   "meta_description"
    t.string   "meta_tags"
    t.string   "tags",                                            array: true
    t.string   "date_slug"
    t.text     "archive_intro"
  end

  add_index "posts", ["date_slug"], name: "index_posts_on_date_slug", using: :btree
  add_index "posts", ["slug"], name: "index_posts_on_slug", using: :btree
  add_index "posts", ["status"], name: "index_posts_on_status", using: :btree
  add_index "posts", ["tags"], name: "posts_tags_index", using: :gin

end
