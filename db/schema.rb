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

ActiveRecord::Schema.define(version: 20150531000033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "monsters", force: :cascade do |t|
    t.string   "name"
    t.text     "image"
    t.integer  "deaths"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "zipcode"
    t.string   "country"
    t.string   "state"
    t.integer  "xp"
    t.integer  "gold"
    t.integer  "level"
    t.integer  "health"
    t.string   "rank"
    t.integer  "attack"
    t.integer  "damage"
    t.integer  "speed"
    t.integer  "defence"
    t.string   "affinity"
    t.integer  "user_id"
    t.boolean  "alive",       default: true
    t.boolean  "tagged",      default: false
    t.integer  "attacker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "zone_id"
  end

  create_table "spellboxes", force: :cascade do |t|
    t.integer "spell_id"
    t.integer "user_id"
    t.integer "amount"
  end

  add_index "spellboxes", ["spell_id"], name: "index_spellboxes_on_spell_id", using: :btree
  add_index "spellboxes", ["user_id"], name: "index_spellboxes_on_user_id", using: :btree

  create_table "spells", force: :cascade do |t|
    t.string   "name"
    t.integer  "attack"
    t.integer  "damage"
    t.integer  "defence"
    t.string   "dmg_type"
    t.integer  "speed"
    t.string   "affinity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spells_users", id: false, force: :cascade do |t|
    t.integer "spell_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.boolean  "admin",           default: false
    t.string   "password_digest"
    t.text     "image"
    t.integer  "deaths"
    t.integer  "highest_level"
    t.integer  "health"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "zipcode"
    t.string   "country"
    t.string   "state"
    t.integer  "xp"
    t.integer  "gold"
    t.integer  "slota"
    t.integer  "slotb"
    t.integer  "level"
    t.integer  "pkills"
    t.integer  "dkills"
    t.integer  "mkills"
    t.boolean  "attackable",      default: false
    t.boolean  "in_battle",       default: false
    t.integer  "attacker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zones", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
