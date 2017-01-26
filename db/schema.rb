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

ActiveRecord::Schema.define(version: 20170119093130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alldeals", id: false, force: :cascade do |t|
    t.text    "name"
    t.text    "start"
    t.text    "stop"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "imgl"
  end

  create_table "cityimg", id: false, force: :cascade do |t|
    t.text "city"
    t.text "thumb"
    t.text "banner"
  end

  create_table "deals_01162017", id: false, force: :cascade do |t|
    t.text    "destination"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
  end

  create_table "deals_01172017", id: false, force: :cascade do |t|
    t.text    "destination"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "flights", force: :cascade do |t|
    t.text     "start"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "header", id: false, force: :cascade do |t|
    t.text "city"
    t.text "banner"
    t.text "slogan"
  end

  create_table "scan_result", id: false, force: :cascade do |t|
    t.text    "fname"
    t.integer "perl"
  end

  create_table "seattle_rome_01162017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattle_rome_01162017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "seattlewasea_romeitalyrom_01172017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattlewasea_romeitalyrom_01172017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "topdeals", id: false, force: :cascade do |t|
    t.text    "name"
    t.text    "start"
    t.text    "stop"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "imgl"
  end

end
