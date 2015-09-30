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

ActiveRecord::Schema.define(version: 20150930074650) do

  create_table "active_galleries", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "active_gallery_photos", force: :cascade do |t|
    t.integer  "active_gallery_id", limit: 4
    t.string   "image",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_gallery_photos", ["active_gallery_id"], name: "index_active_gallery_photos_on_active_gallery_id", using: :btree

  create_table "article_translations", force: :cascade do |t|
    t.integer  "article_id", limit: 4,   null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
  end

  add_index "article_translations", ["article_id"], name: "index_article_translations_on_article_id", using: :btree
  add_index "article_translations", ["locale"], name: "index_article_translations_on_locale", using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer  "author_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_position",   limit: 4
    t.datetime "publish_time"
    t.integer  "active_gallery_id", limit: 4
    t.integer  "status",            limit: 4
  end

  add_index "articles", ["active_gallery_id"], name: "index_articles_on_active_gallery_id", using: :btree
  add_index "articles", ["author_id"], name: "index_articles_on_author_id", using: :btree

  create_table "author_rubrics", force: :cascade do |t|
    t.integer "author_id", limit: 4, null: false
    t.integer "rubric_id", limit: 4, null: false
    t.integer "position",  limit: 4
  end

  create_table "author_translations", force: :cascade do |t|
    t.integer  "author_id",  limit: 4,   null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo",      limit: 255
  end

  add_index "author_translations", ["author_id"], name: "index_author_translations_on_author_id", using: :btree
  add_index "author_translations", ["locale"], name: "index_author_translations_on_locale", using: :btree

  create_table "authors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubrics", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
