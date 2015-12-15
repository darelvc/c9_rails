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

ActiveRecord::Schema.define(version: 20151215094227) do

  create_table "chefs", force: :cascade do |t|
    t.string   "chefname"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
  end

  create_table "likes", force: :cascade do |t|
    t.boolean  "like"
    t.integer  "chef_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer "ingredient_id"
    t.integer "recipe_id"
  end

  create_table "recipe_styles", force: :cascade do |t|
    t.integer "style_id"
    t.integer "recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string   "name"
    t.text     "summary"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "chef_id"
    t.string   "picture"
  end

  create_table "styles", force: :cascade do |t|
    t.string "name"
  end

end
