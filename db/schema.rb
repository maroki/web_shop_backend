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

ActiveRecord::Schema.define(version: 20170425220737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "basket_products", force: :cascade do |t|
    t.integer  "basket_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_basket_products_on_basket_id", using: :btree
    t.index ["product_id"], name: "index_basket_products_on_product_id", using: :btree
  end

  create_table "baskets", force: :cascade do |t|
    t.decimal  "full_price", precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity"
    t.decimal  "price",      precision: 8, scale: 2
    t.boolean  "available",                          default: true, null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

end
