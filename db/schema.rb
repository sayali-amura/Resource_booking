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

ActiveRecord::Schema.define(version: 20160921051952) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "status",          default: 0
    t.integer  "priority"
    t.string   "feedback"
    t.string   "comment"
    t.boolean  "shift",           default: false
    t.integer  "employee_id"
    t.date     "date_of_booking"
    t.float    "duration"
  end

  add_index "bookings", ["employee_id"], name: "index_bookings_on_employee_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
    t.string   "address"
    t.string   "password_digest"
  end

  create_table "complaints", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "comment"
    t.integer  "status"
    t.integer  "resource_id"
    t.integer  "employee_id"
  end

  add_index "complaints", ["employee_id"], name: "index_complaints_on_employee_id", using: :btree

  create_table "employees", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.integer  "age"
    t.date     "date_of_joining"
    t.integer  "manager_id"
    t.integer  "role_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "employees", ["confirmation_token"], name: "index_employees_on_confirmation_token", unique: true, using: :btree
  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content"
    t.integer  "booking_id"
  end

  add_index "messages", ["booking_id"], name: "index_messages_on_booking_id", using: :btree

  create_table "resources", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.integer  "count"
  end

  add_index "resources", ["name"], name: "index_resources_on_name", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "designation"
    t.string   "department"
    t.integer  "priority"
  end

end
