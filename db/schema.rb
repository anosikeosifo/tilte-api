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

ActiveRecord::Schema.define(version: 20170311182338) do

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "text"
    t.integer  "like_count", default: 0
    t.integer  "user_id"
    t.integer  "post_id"
    t.boolean  "flagged",    default: false
    t.boolean  "removed",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
    t.index ["text"], name: "index_comments_on_text", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "event_attendees", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id"
    t.integer "attendee_id"
    t.index ["attendee_id"], name: "index_event_attendees_on_attendee_id", using: :btree
    t.index ["event_id"], name: "index_event_attendees_on_event_id", using: :btree
  end

  create_table "event_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "is_active",   default: false
    t.boolean  "is_featured", default: false
  end

  create_table "event_locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id"
    t.integer "location_id"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "title"
    t.text    "description",       limit: 65535
    t.decimal "price",                           precision: 10, default: 0
    t.string  "start_time",        limit: 15
    t.string  "end_time",          limit: 15
    t.integer "organizer_id"
    t.integer "event_category_id"
    t.string  "created_at"
    t.string  "updated_at"
    t.integer "attendee_count",                                 default: 0
    t.integer "post_count",                                     default: 0
    t.integer "rating",                                         default: 0
    t.index ["event_category_id"], name: "index_events_on_event_category_id", using: :btree
    t.index ["organizer_id"], name: "index_events_on_organizer_id", using: :btree
  end

  create_table "favorites", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id"
    t.integer "post_id"
    t.index ["post_id"], name: "index_favorites_on_post_id", using: :btree
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "longitude"
    t.string   "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "image_url"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "removed",         default: false
    t.string   "image"
    t.integer  "favorites_count", default: 0
    t.integer  "comments_count",  default: 0
    t.integer  "repost_id"
    t.integer  "reposts_count",   default: 0
    t.integer  "event_id"
    t.index ["event_id"], name: "index_posts_on_event_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repost_relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "reposter_id"
    t.integer  "owner_id"
    t.integer  "post_id"
    t.integer  "repost_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["owner_id"], name: "index_repost_relationships_on_owner_id", using: :btree
    t.index ["post_id"], name: "index_repost_relationships_on_post_id", using: :btree
    t.index ["repost_id"], name: "index_repost_relationships_on_repost_id", using: :btree
    t.index ["reposter_id"], name: "index_repost_relationships_on_reposter_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
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
    t.string   "profile_photo_url"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "events", "users", column: "organizer_id"
end
