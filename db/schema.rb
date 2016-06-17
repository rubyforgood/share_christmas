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

ActiveRecord::Schema.define(version: 20160617191148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.integer  "volunteer_center_id"
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "campaigns", ["volunteer_center_id"], name: "index_campaigns_on_volunteer_center_id", using: :btree

  create_table "donors", force: :cascade do |t|
    t.integer  "organization_campaign_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "donors", ["organization_campaign_id"], name: "index_donors_on_organization_campaign_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "donor_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "matches", ["donor_id"], name: "index_matches_on_donor_id", using: :btree
  add_index "matches", ["recipient_id"], name: "index_matches_on_recipient_id", using: :btree

  create_table "organization_campaigns", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "campaign_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "organization_campaigns", ["campaign_id"], name: "index_organization_campaigns_on_campaign_id", using: :btree
  add_index "organization_campaigns", ["organization_id"], name: "index_organization_campaigns_on_organization_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.integer  "volunteer_center_id"
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "organizations", ["volunteer_center_id"], name: "index_organizations_on_volunteer_center_id", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.integer  "organization_campaign_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "recipients", ["organization_campaign_id"], name: "index_recipients_on_organization_campaign_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "volunteer_centers", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "campaigns", "volunteer_centers"
  add_foreign_key "donors", "organization_campaigns"
  add_foreign_key "matches", "donors"
  add_foreign_key "matches", "recipients"
  add_foreign_key "organization_campaigns", "campaigns"
  add_foreign_key "organization_campaigns", "organizations"
  add_foreign_key "organizations", "volunteer_centers"
  add_foreign_key "recipients", "organization_campaigns"
end
