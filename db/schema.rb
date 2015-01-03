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

ActiveRecord::Schema.define(version: 20150103141503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: true do |t|
    t.integer  "job_id"
    t.integer  "contractor_id"
    t.integer  "cost"
    t.boolean  "accepted",      default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "rejected",      default: false
  end

  add_index "bids", ["contractor_id", "job_id"], name: "index_bids_on_contractor_id_and_job_id", unique: true, using: :btree
  add_index "bids", ["contractor_id"], name: "index_bids_on_contractor_id", using: :btree
  add_index "bids", ["job_id"], name: "index_bids_on_job_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.string   "subject"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commenterable_id"
    t.string   "commenterable_type"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["commenterable_id", "commenterable_type"], name: "index_comments_on_commenterable_id_and_commenterable_type", using: :btree

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
    t.text     "categories",                         default: [],              array: true
    t.string   "name"
    t.text     "description"
    t.string   "phone"
    t.string   "address"
    t.string   "company_name"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "search_radius"
  end

  add_index "contractors", ["address"], name: "index_contractors_on_address", using: :btree
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
    t.string   "description"
    t.integer  "duration"
    t.string   "duration_unit"
    t.integer  "cost"
    t.integer  "contractor_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "categories",    default: [],              array: true
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "examples", ["categories"], name: "index_examples_on_categories", using: :gin
  add_index "examples", ["contractor_id"], name: "index_examples_on_contractor_id", using: :btree
  add_index "examples", ["latitude"], name: "index_examples_on_latitude", using: :btree
  add_index "examples", ["longitude"], name: "index_examples_on_longitude", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "contractor_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "phone"
    t.date     "bid_date"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.date     "bidding_period"
    t.integer  "cost"
    t.text     "categories",     default: [],                       array: true
    t.string   "state",          default: "searching"
  end

  add_index "jobs", ["address"], name: "index_jobs_on_address", using: :btree
  add_index "jobs", ["categories"], name: "index_jobs_on_categories", using: :gin
  add_index "jobs", ["contractor_id"], name: "index_jobs_on_contractor_id", using: :btree
  add_index "jobs", ["latitude"], name: "index_jobs_on_latitude", using: :btree
  add_index "jobs", ["longitude"], name: "index_jobs_on_longitude", using: :btree
  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "mailboxer_conversation_opt_outs", force: true do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: true do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "reviews", force: true do |t|
    t.text     "description"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "quality",           default: 5, null: false
    t.integer  "cost",              default: 5, null: false
    t.integer  "timeliness",        default: 5, null: false
    t.integer  "professionalism",   default: 5, null: false
    t.integer  "recommendation",    default: 5, null: false
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.integer  "reviewerable_id"
    t.string   "reviewerable_type"
  end

  add_index "reviews", ["reviewable_id", "reviewable_type"], name: "index_reviews_on_reviewable_id_and_reviewable_type", using: :btree
  add_index "reviews", ["reviewerable_id", "reviewerable_type"], name: "index_reviews_on_reviewerable_id_and_reviewerable_type", using: :btree

  create_table "searches", force: true do |t|
    t.string   "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "searches", ["zip_code"], name: "index_searches_on_zip_code", using: :btree

  create_table "uploads", force: true do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "uploadable_id"
    t.string   "uploadable_type"
    t.boolean  "before",             default: false
    t.boolean  "after",              default: false
    t.boolean  "image_processing"
  end

  add_index "uploads", ["uploadable_id", "uploadable_type"], name: "index_uploads_on_uploadable_id_and_uploadable_type", using: :btree

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
    t.string   "phone"
    t.text     "categories",                         default: [],              array: true
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "users", ["address"], name: "index_users_on_address", using: :btree
  add_index "users", ["categories"], name: "index_users_on_categories", using: :gin
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["latitude"], name: "index_users_on_latitude", using: :btree
  add_index "users", ["longitude"], name: "index_users_on_longitude", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
