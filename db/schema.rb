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

ActiveRecord::Schema.define(:version => 20121128203001) do

  create_table "participants", :force => true do |t|
    t.integer  "program_id"
    t.integer  "user_id"
    t.string   "guid"
    t.boolean  "hidden"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "programs", :force => true do |t|
    t.string   "name"
    t.integer  "moderator_id"
    t.string   "description"
    t.boolean  "open"
    t.boolean  "locked"
    t.boolean  "suppress_hidden_participants", :default => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "text"
    t.integer  "pos"
    t.integer  "program_id"
    t.text     "active"
    t.text     "data_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "responses", :force => true do |t|
    t.string   "value"
    t.integer  "round_id"
    t.integer  "participant_id"
    t.integer  "question_id"
    t.integer  "program_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "rounds", :force => true do |t|
    t.integer  "program_id"
    t.integer  "number"
    t.integer  "start"
    t.integer  "fin"
    t.text     "status"
    t.boolean  "open"
    t.datetime "open_date"
    t.datetime "close_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "name",                   :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "roles_mask",             :default => 0,  :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
