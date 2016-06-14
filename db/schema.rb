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

ActiveRecord::Schema.define(version: 20160613225604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.integer  "holiday_id",                           null: false
    t.string   "name",       limit: 50,                null: false
    t.boolean  "active",                default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["holiday_id"], name: "index_campaigns_on_holiday_id", using: :btree
  add_index "campaigns", ["name"], name: "index_campaigns_on_name", using: :btree

  create_table "deadlines", force: :cascade do |t|
    t.integer  "campaign_id",               null: false
    t.string   "name",          limit: 60,  null: false
    t.date     "due_date",                  null: false
    t.time     "due_time"
    t.date     "reminder_date"
    t.string   "description",   limit: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deadlines", ["campaign_id"], name: "index_deadlines_on_campaign_id", using: :btree

  create_table "givers", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.string   "email",      limit: 200, null: false
    t.string   "phone",      limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "givers", ["email"], name: "index_givers_on_email", using: :btree

  create_table "holidays", force: :cascade do |t|
    t.string   "name",       limit: 100,                null: false
    t.string   "season"
    t.text     "about"
    t.boolean  "active",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "holidays", ["name"], name: "index_holidays_on_name", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "giver_id",     null: false
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["giver_id"], name: "index_matches_on_giver_id", using: :btree
  add_index "matches", ["recipient_id"], name: "index_matches_on_recipient_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",         limit: 100,                null: false
    t.string   "key",          limit: 50
    t.string   "email_from",   limit: 100
    t.string   "image_uid",    limit: 500
    t.string   "image_name",   limit: 100
    t.boolean  "active",                   default: true, null: false
    t.text     "instructions"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["key"], name: "index_organizations_on_key", using: :btree
  add_index "organizations", ["name"], name: "index_organizations_on_name", using: :btree

  create_table "recipient_families", force: :cascade do |t|
    t.integer  "campaign_id",                                  null: false
    t.integer  "organization_id"
    t.integer  "social_worker_id",                             null: false
    t.integer  "casenumber"
    t.string   "last_name",        limit: 40,                  null: false
    t.string   "first_name",       limit: 40
    t.string   "address",          limit: 200
    t.string   "city",             limit: 50
    t.string   "state",            limit: 2,    default: "NC"
    t.string   "zip",              limit: 10
    t.string   "phone",            limit: 100
    t.string   "profile",          limit: 2000
    t.boolean  "deliverable",                   default: true, null: false
    t.string   "latlng",           limit: 60
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipient_families", ["campaign_id"], name: "index_recipient_families_on_campaign_id", using: :btree
  add_index "recipient_families", ["casenumber"], name: "index_recipient_families_on_casenumber", using: :btree
  add_index "recipient_families", ["organization_id"], name: "index_recipient_families_on_organization_id", using: :btree
  add_index "recipient_families", ["social_worker_id"], name: "index_recipient_families_on_social_worker_id", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.integer  "recipient_family_id",                                                      null: false
    t.integer  "match_id"
    t.string   "first_name",          limit: 60,                                           null: false
    t.decimal  "age",                              precision: 5, scale: 2
    t.string   "gender",              limit: 1
    t.string   "race",                limit: 1
    t.string   "size"
    t.string   "need",                limit: 1000
    t.boolean  "bike",                                                     default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipients", ["recipient_family_id", "age"], name: "index_recipients_on_recipient_family_id_and_age", using: :btree

  create_table "social_workers", force: :cascade do |t|
    t.string   "name",       limit: 100,                null: false
    t.string   "email",      limit: 200
    t.string   "phone",      limit: 20
    t.boolean  "active",                 default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_workers", ["name"], name: "index_social_workers_on_name", using: :btree

end
