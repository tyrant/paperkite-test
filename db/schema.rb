# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_30_050115) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "packaging_groups", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_promotions", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "promotion_id"
    t.integer "bundle_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_promotions_on_product_id"
    t.index ["promotion_id"], name: "index_product_promotions_on_promotion_id"
  end

  create_table "products", force: :cascade do |t|
    t.decimal "price"
    t.boolean "is_available"
    t.integer "display_order"
    t.string "image_url"
    t.string "packaging_group"
    t.string "name"
    t.integer "volume"
    t.bigint "vending_machine_id"
    t.bigint "packaging_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["packaging_group_id"], name: "index_products_on_packaging_group_id"
    t.index ["vending_machine_id"], name: "index_products_on_vending_machine_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "description"
    t.decimal "cost"
    t.decimal "discount"
    t.string "image_url"
    t.string "promotion_type"
    t.boolean "is_happy_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vending_machines", force: :cascade do |t|
    t.integer "outlet_number"
    t.string "plate_number"
    t.text "vendor_address"
    t.integer "promo_expiry_seconds"
    t.boolean "is_happy_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
