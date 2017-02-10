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

ActiveRecord::Schema.define(version: 20170128225911) do

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

  create_table "c_4_seattlesea_londonheathrowlhr_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_4_seattlesea_londonheathrowlhr_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_6_londonlon_boiseairterminalboi_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_6_londonlon_boiseairterminalboi_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_8_londonlon_boiseairterminalboi_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_8_londonlon_boiseairterminalboi_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_charlottedouglasinternationalairportclt_capetowninternational", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_dhakadac_losangeleslax_01222017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_dhakadac_losangeleslax_01222017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_dhakadac_newyorkcitynyc_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_dhakadac_newyorkcitynyc_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_londongatwicklgw_newyorkcitynyc_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_londongatwicklgw_newyorkcitynyc_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_londonheathrowairportlhr_losangeleslax_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_londonheathrowairportlhr_losangeleslax_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_londonheathrowlhr_newyorkcitylga_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_londonheathrowlhr_newyorkcitylga_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_londonlon_boiseairterminalboi_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_londonlon_boiseairterminalboi_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_londonlon_newyorkcitynyc_01222017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_londonlon_newyorkcitynyc_01222017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_losangeleslax_dhakadac_01242017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_losangeleslax_dhakadac_01242017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_newyorkcityewr_dhakadac_01242017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_newyorkcityewr_dhakadac_01242017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_newyorkcitynyc_amsterdamams_01252017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_newyorkcitynyc_amsterdamams_01252017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_newyorkcitynyc_dhakadac_01242017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_newyorkcitynyc_dhakadac_01242017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_newyorkcitynyc_seattlesea_01252017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_newyorkcitynyc_seattlesea_01252017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_parispar_phoenixskyharborphx_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_parispar_phoenixskyharborphx_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_sanfranciscosfo_dhakadac_01242017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_sanfranciscosfo_dhakadac_01242017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_seattlesea_charlottedouglasinternationalairportclt_01222017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_seattlesea_charlottedouglasinternationalairportclt_01222017_l", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_seattlesea_dhakadac_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_seattlesea_dhakadac_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_seattlesea_dhakadac_01242017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_seattlesea_dhakadac_01242017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_seattlesea_honoluluhnl_01262017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_seattlesea_honoluluhnl_01262017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_seattlesea_miamiinternationalairportmia_01222017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_seattlesea_miamiinternationalairportmia_01222017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_seattlesea_miamimia_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_seattlesea_miamimia_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_seattlesea_milanmil_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_seattlesea_milanmil_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_seattlesea_newyorkcitynyc_01222017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_seattlesea_newyorkcitynyc_01222017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_seattlesea_romerom_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_seattlesea_romerom_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_washingtondciad_seattlesea_01252017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_washingtondciad_seattlesea_01252017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
  end

  create_table "c_washingtondcwas_seattlesea_01252017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "c_washingtondcwas_seattlesea_01252017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
    t.text    "result"
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

  create_table "deals_01192017", id: false, force: :cascade do |t|
    t.text    "destination"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
  end

  create_table "deals_01202017", id: false, force: :cascade do |t|
    t.text    "destination"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
  end

  create_table "deals_01232017", id: false, force: :cascade do |t|
    t.text    "destination"
    t.text    "date"
    t.integer "price"
    t.integer "avgp"
    t.integer "perl"
  end

  create_table "deals_01252017", id: false, force: :cascade do |t|
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

  create_table "dhakadac_losangelesinternationalairportlax_01202017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "dhakadac_losangelesinternationalairportlax_01202017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
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

  create_table "londonlon_mumbaibom_01212017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "londonlon_mumbaibom_01212017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "losangelesinternationalairportlax_chicagochi_01202017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "losangelesinternationalairportlax_chicagochi_01202017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "losangelesinternationalairportlax_dhakadac_01202017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "losangelesinternationalairportlax_dhakadac_01202017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "newyorkcitynyc_riodejaneirorio_01192017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "newyorkcitynyc_riodejaneirorio_01192017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "newyorkcitynyc_romerom_01202017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "newyorkcitynyc_romerom_01202017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "scan_result", id: false, force: :cascade do |t|
    t.text     "fname"
    t.integer  "perl"
    t.integer  "tripl"
    t.text     "status"
    t.datetime "stime"
  end

  create_table "seattle_london_01192017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattle_london_01192017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "seattle_miami_01192017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattle_miami_01192017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
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

  create_table "seattlesea_bangkokbkk_01202017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattlesea_bangkokbkk_01202017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "seattlesea_londonheathrowairportlhr_01212017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattlesea_londonheathrowairportlhr_01212017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "seattlesea_londonlon_01202017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattlesea_londonlon_01202017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "seattlesea_miamimia_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattlesea_miamimia_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "seattlesea_milanmil_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattlesea_milanmil_01232017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

  create_table "seattlesea_romerom_01232017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "seattlesea_romerom_01232017_low", id: false, force: :cascade do |t|
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

  create_table "torontoyto_londonlon_01212017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "torontoyto_londonlon_01212017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "ran"
    t.string   "running"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "washingtondcwas_seattlesea_01252017", id: false, force: :cascade do |t|
    t.text "tripl"
    t.json "dp"
  end

  create_table "washingtondcwas_seattlesea_01252017_low", id: false, force: :cascade do |t|
    t.integer "tripl"
    t.text    "date"
    t.integer "price"
  end

end
