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

ActiveRecord::Schema.define(version: 20141001155800) do

  create_table "article_translations", force: true do |t|
    t.integer  "article_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "article_translations", ["article_id"], name: "index_article_translations_on_article_id", using: :btree
  add_index "article_translations", ["locale"], name: "index_article_translations_on_locale", using: :btree

  create_table "articles", force: true do |t|
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_position"
    t.datetime "publish_time"
  end

  add_index "articles", ["author_id"], name: "index_articles_on_author_id", using: :btree

  create_table "author_rubrics", force: true do |t|
    t.integer "author_id", null: false
    t.integer "rubric_id", null: false
    t.integer "position"
  end

  create_table "author_translations", force: true do |t|
    t.integer  "author_id",  null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo"
  end

  add_index "author_translations", ["author_id"], name: "index_author_translations_on_author_id", using: :btree
  add_index "author_translations", ["locale"], name: "index_author_translations_on_locale", using: :btree

  create_table "authors", force: true do |t|
    t.string   "name"
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubrics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
