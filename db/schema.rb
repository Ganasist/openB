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

ActiveRecord::Schema.define(version: 20141028110006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: true do |t|
    t.integer  "job_id"
    t.integer  "contractor_id"
    t.integer  "cost"
    t.integer  "duration"
    t.string   "duration_unit"
    t.boolean  "accepted"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "bids", ["contractor_id"], name: "index_bids_on_contractor_id", using: :btree
  add_index "bids", ["job_id"], name: "index_bids_on_job_id", using: :btree

  create_table "contractors", force: true do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",                    default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",                  default: 0
    t.string   "categories",                         default: [],              array: true
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "image_processing"
    t.text     "bio"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "company_name"
    t.integer  "zip_code"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "contractors", ["categories"], name: "index_contractors_on_categories", using: :gin
  add_index "contractors", ["confirmation_token"], name: "index_contractors_on_confirmation_token", unique: true, using: :btree
  add_index "contractors", ["email"], name: "index_contractors_on_email", unique: true, using: :btree
  add_index "contractors", ["invitation_token"], name: "index_contractors_on_invitation_token", unique: true, using: :btree
  add_index "contractors", ["invitations_count"], name: "index_contractors_on_invitations_count", using: :btree
  add_index "contractors", ["invited_by_id"], name: "index_contractors_on_invited_by_id", using: :btree
  add_index "contractors", ["latitude"], name: "index_contractors_on_latitude", using: :btree
  add_index "contractors", ["longitude"], name: "index_contractors_on_longitude", using: :btree
  add_index "contractors", ["reset_password_token"], name: "index_contractors_on_reset_password_token", unique: true, using: :btree
  add_index "contractors", ["unlock_token"], name: "index_contractors_on_unlock_token", unique: true, using: :btree

  create_table "examples", force: true do |t|
    t.string   "title"
    t.integer  "zip_code"
    t.string   "description"
    t.integer  "duration"
    t.string   "duration_unit"
    t.integer  "cost"
    t.integer  "portfolio_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "categories",    default: [],              array: true
  end

  add_index "examples", ["portfolio_id"], name: "index_examples_on_portfolio_id", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "zip_code"
    t.integer  "user_id"
    t.integer  "contractor_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "image_processing"
    t.string   "categories",         default: [],              array: true
    t.string   "phone"
    t.integer  "cost"
    t.integer  "duration"
    t.string   "duration_unit"
    t.date     "bid_date"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "city"
    t.string   "state"
  end

  add_index "jobs", ["address"], name: "index_jobs_on_address", using: :btree
  add_index "jobs", ["categories"], name: "index_jobs_on_categories", using: :gin
  add_index "jobs", ["contractor_id"], name: "index_jobs_on_contractor_id", using: :btree
  add_index "jobs", ["latitude"], name: "index_jobs_on_latitude", using: :btree
  add_index "jobs", ["longitude"], name: "index_jobs_on_longitude", using: :btree
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "portfolios", force: true do |t|
    t.integer  "job_id"
    t.integer  "contractor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "portfolios", ["contractor_id"], name: "index_portfolios_on_contractor_id", using: :btree
  add_index "portfolios", ["job_id"], name: "index_portfolios_on_job_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: ""
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "role"
    t.string   "invitation_token",       limit: 255
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type",        limit: 255
    t.integer  "invitations_count",                  default: 0
    t.integer  "failed_attempts",                    default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.integer  "zip_code"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "image_processing"
    t.string   "phone"
    t.string   "categories",                         default: [],              array: true
    t.string   "city"
    t.string   "address"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "users", ["address"], name: "index_users_on_address", using: :btree
  add_index "users", ["categories"], name: "index_users_on_categories", using: :gin
  add_index "users", ["city"], name: "index_users_on_city", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["latitude"], name: "index_users_on_latitude", using: :btree
  add_index "users", ["longitude"], name: "index_users_on_longitude", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["zip_code"], name: "index_users_on_zip_code", using: :btree

end
