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

ActiveRecord::Schema.define(version: 20160911040644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amendments", id: false, force: :cascade do |t|
    t.string   "amendment_id",   null: false
    t.string   "introduced_on"
    t.string   "last_action_at"
    t.string   "purpose"
    t.string   "amends_bill_id", null: false
    t.string   "sponsor_id",     null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["amendment_id"], name: "index_amendments_on_amendment_id", unique: true, using: :btree
    t.index ["amends_bill_id"], name: "index_amendments_on_amends_bill_id", using: :btree
    t.index ["sponsor_id"], name: "index_amendments_on_sponsor_id", using: :btree
  end

  create_table "bills", id: false, force: :cascade do |t|
    t.string   "bill_id",                       null: false
    t.string   "chamber"
    t.string   "short_title"
    t.string   "official_title"
    t.string   "sponsor_id"
    t.datetime "introduced_on"
    t.datetime "last_action_at"
    t.string   "pdf"
    t.json     "history"
    t.string   "related_bill_ids", default: [],              array: true
    t.string   "committee_ids",    default: [],              array: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["bill_id"], name: "index_bills_on_bill_id", unique: true, using: :btree
  end

  create_table "cast_votes", force: :cascade do |t|
    t.string   "legislator_id", null: false
    t.string   "roll_id",       null: false
    t.string   "vote_cast",     null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["legislator_id", "roll_id"], name: "index_cast_votes_on_legislator_id_and_roll_id", unique: true, using: :btree
    t.index ["legislator_id"], name: "index_cast_votes_on_legislator_id", using: :btree
    t.index ["roll_id"], name: "index_cast_votes_on_roll_id", using: :btree
  end

  create_table "committee_memberships", force: :cascade do |t|
    t.string   "committee_id",  null: false
    t.string   "legislator_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["committee_id", "legislator_id"], name: "index_committee_memberships_on_committee_id_and_legislator_id", unique: true, using: :btree
  end

  create_table "committees", id: false, force: :cascade do |t|
    t.string   "committee_id",        null: false
    t.string   "chamber"
    t.string   "name"
    t.string   "member_ids"
    t.string   "parent_committee_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["committee_id"], name: "index_committees_on_committee_id", unique: true, using: :btree
  end

  create_table "legislators", id: false, force: :cascade do |t|
    t.string   "bioguide_id", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "state"
    t.string   "chamber"
    t.string   "party"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["bioguide_id"], name: "index_legislators_on_bioguide_id", unique: true, using: :btree
  end

  create_table "votes", id: false, force: :cascade do |t|
    t.string   "roll_id",    null: false
    t.string   "chamber"
    t.string   "congress"
    t.integer  "number"
    t.string   "question"
    t.string   "required"
    t.string   "result"
    t.string   "bill_id"
    t.string   "roll_type"
    t.string   "url"
    t.string   "vote_type"
    t.string   "voted_at"
    t.string   "year"
    t.json     "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roll_id"], name: "index_votes_on_roll_id", unique: true, using: :btree
  end

end
