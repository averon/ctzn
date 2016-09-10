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

ActiveRecord::Schema.define(version: 20160908052710) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string   "bill_id"
    t.string   "chamber"
    t.string   "short_title"
    t.string   "official_title"
    t.string   "sponsor_id"
    t.datetime "introduced_on"
    t.datetime "last_action_at"
    t.string   "pdf"
    t.json     "history"
    t.string   "related_bill_ids", default: [],              array: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "cast_votes", force: :cascade do |t|
    t.string   "legislator_id", null: false
    t.string   "roll_id",       null: false
    t.string   "vote_cast",     null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "legislators", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "state"
    t.string   "chamber"
    t.string   "party"
    t.string   "bioguide_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "votes", force: :cascade do |t|
    t.string   "chamber"
    t.string   "congress"
    t.integer  "number"
    t.string   "question"
    t.string   "required"
    t.string   "result"
    t.string   "bill_id"
    t.string   "roll_id"
    t.string   "roll_type"
    t.string   "url"
    t.string   "vote_type"
    t.string   "voted_at"
    t.string   "year"
    t.json     "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
