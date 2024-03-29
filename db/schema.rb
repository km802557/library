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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130115084354) do

  create_table "authors", :force => true do |t|
    t.string   "lastname"
    t.string   "firstname"
    t.string   "labo"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "nickname"
    t.string   "remember_token"
  end

  add_index "authors", ["nickname"], :name => "index_authors_on_nickname", :unique => true
  add_index "authors", ["remember_token"], :name => "index_authors_on_remember_token"

  create_table "publications", :force => true do |t|
    t.string   "title"
    t.integer  "author_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "publications", ["author_id", "created_at"], :name => "index_publications_on_author_id_and_created_at"

end
