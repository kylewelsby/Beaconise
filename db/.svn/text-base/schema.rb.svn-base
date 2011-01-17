# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100907121253) do

  create_table "acts", :force => true do |t|
    t.integer  "artist_id"
    t.integer  "event_id"
    t.string   "permalink"
    t.integer  "position",    :default => 0
    t.integer  "importance",  :default => 0
    t.time     "commence_at"
    t.time     "finish_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["confirmation_token"], :name => "index_admins_on_confirmation_token", :unique => true
  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true
  add_index "admins", ["unlock_token"], :name => "index_admins_on_unlock_token", :unique => true

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.string   "mbid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendees", :force => true do |t|
    t.string   "state"
    t.string   "method",     :default => "web"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attendees", ["event_id"], :name => "index_attendees_on_attendable_id"
  add_index "attendees", ["user_id"], :name => "index_attendees_on_user_id"

  create_table "businesses", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "facebook_uid",         :limit => 8
    t.string   "facebook_session_key", :limit => 149
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "businesses", ["confirmation_token"], :name => "index_businesses_on_confirmation_token", :unique => true
  add_index "businesses", ["email"], :name => "index_businesses_on_email", :unique => true
  add_index "businesses", ["facebook_uid"], :name => "index_businesses_on_facebook_uid", :unique => true
  add_index "businesses", ["reset_password_token"], :name => "index_businesses_on_reset_password_token", :unique => true
  add_index "businesses", ["unlock_token"], :name => "index_businesses_on_unlock_token", :unique => true

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.string   "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["locked_by"], :name => "index_delayed_jobs_on_locked_by"

  create_table "event_prices", :force => true do |t|
    t.integer  "event_id"
    t.integer  "amount"
    t.integer  "price"
    t.datetime "commence_at"
    t.datetime "finish_at"
    t.boolean  "student"
    t.boolean  "member"
    t.boolean  "female"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "venue_id"
    t.integer  "promoter_id"
    t.string   "title"
    t.string   "permalink"
    t.text     "description"
    t.integer  "avalable_tickets"
    t.string   "currency"
    t.string   "min_age"
    t.datetime "commence_at"
    t.datetime "finish_at"
    t.datetime "canceled_at"
    t.string   "canceled_reason"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.string   "poster_file_size"
    t.string   "tilllate_id"
    t.string   "songkick_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_photos", :id => false, :force => true do |t|
    t.integer  "event_id",   :null => false
    t.integer  "photo_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events_photos", ["event_id", "photo_id"], :name => "index_events_photos_on_event_id_and_photo_id"

  create_table "galleries", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "photo_id"
    t.string   "title",            :null => false
    t.string   "permalink"
    t.string   "description"
    t.string   "location"
    t.boolean  "profile_pictures"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "galleries_photos", :id => false, :force => true do |t|
    t.integer  "gallery_id", :null => false
    t.integer  "photo_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "galleries_photos", ["gallery_id", "photo_id"], :name => "index_galleries_photos_on_gallery_id_and_photo_id"

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres_venues", :id => false, :force => true do |t|
    t.integer "venue_id"
    t.integer "genre_id"
  end

  create_table "messages", :force => true do |t|
    t.boolean  "receiver_deleted"
    t.boolean  "receiver_purged"
    t.boolean  "sender_deleted"
    t.boolean  "sender_purged"
    t.datetime "read_at"
    t.integer  "receiver_id"
    t.integer  "sender_id"
    t.string   "subject",          :null => false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["receiver_id"], :name => "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.string   "photo_file_size"
    t.string   "source"
    t.string   "eid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "taken_at"
    t.string   "device_make"
    t.string   "device_model"
    t.integer  "geo_lat",            :limit => 10, :precision => 10, :scale => 0
    t.integer  "geo_lon",            :limit => 10, :precision => 10, :scale => 0
  end

  create_table "promoters", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "facebook_uid",         :limit => 8
    t.string   "facebook_session_key", :limit => 149
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "permalink"
  end

  add_index "promoters", ["confirmation_token"], :name => "index_promoters_on_confirmation_token", :unique => true
  add_index "promoters", ["email"], :name => "index_promoters_on_email", :unique => true
  add_index "promoters", ["facebook_uid"], :name => "index_promoters_on_facebook_uid", :unique => true
  add_index "promoters", ["reset_password_token"], :name => "index_promoters_on_reset_password_token", :unique => true
  add_index "promoters", ["unlock_token"], :name => "index_promoters_on_unlock_token", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "facebook_uid",         :limit => 8
    t.string   "facebook_session_key", :limit => 149
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "permalink"
    t.boolean  "female"
    t.date     "born_on"
    t.string   "forename"
    t.string   "surname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "county"
    t.string   "country"
    t.string   "postcode"
    t.string   "mobile"
    t.string   "network"
    t.string   "twitter"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["facebook_uid"], :name => "index_users_on_facebook_uid", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "users_promoters", :force => true do |t|
    t.integer "user_id"
    t.integer "promoter_id"
  end

  create_table "venue_times", :force => true do |t|
    t.string   "venue_id"
    t.string   "day",        :null => false
    t.time     "open_at",    :null => false
    t.time     "close_at",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", :force => true do |t|
    t.integer  "business_id"
    t.string   "name",              :null => false
    t.string   "permalink",         :null => false
    t.string   "keyword"
    t.text     "description"
    t.text     "dress_code"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "county"
    t.string   "country"
    t.string   "postcode"
    t.string   "lat"
    t.string   "lng"
    t.string   "website"
    t.string   "email"
    t.string   "telephone"
    t.string   "twitter"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.string   "logo_file_size"
    t.string   "tilllate_id"
    t.integer  "songkick_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues_galleries", :id => false, :force => true do |t|
    t.integer  "gallery_id", :null => false
    t.integer  "venue_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues_galleries", ["gallery_id", "venue_id"], :name => "index_venues_galleries_on_gallery_id_and_venue_id"

end
