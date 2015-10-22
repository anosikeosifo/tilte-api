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

ActiveRecord::Schema.define(version: 20151022042029) do

  create_table "comments", force: true do |t|
    t.string   "text"
    t.integer  "like_count", default: 0
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "flagged",    default: false
    t.boolean  "removed",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "favorites", force: true do |t|
    t.integer "user_id"
    t.integer "post_id"
  end

  add_index "favorites", ["post_id"], name: "index_favorites_on_post_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.string   "image_url"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "removed",        default: false
    t.string   "image"
    t.integer  "favorite_count", default: 0
    t.integer  "comments_count", default: 0
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id", null: false
    t.integer  "followed_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "idx_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "idx_followed_follower", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "idx_follower_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "auth_token",             default: ""
    t.string   "username"
    t.string   "fullname"
    t.string   "avatar"
    t.integer  "posts_count",            default: 0
    t.integer  "favorites_count",        default: 0
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
