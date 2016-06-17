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

ActiveRecord::Schema.define(version: 20160617155939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.integer  "volunteer_center_id"
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "campaigns", ["volunteer_center_id"], name: "index_campaigns_on_volunteer_center_id", using: :btree

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

  create_table "volunteer_centers", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "campaigns", "volunteer_centers"
  add_foreign_key "organization_campaigns", "campaigns"
  add_foreign_key "organization_campaigns", "organizations"
  add_foreign_key "organizations", "volunteer_centers"
end
