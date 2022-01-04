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

ActiveRecord::Schema.define(version: 2021_12_30_211135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coach_problem", id: false, force: :cascade do |t|
    t.bigint "coach_id"
    t.bigint "problem_id"
    t.index ["coach_id"], name: "index_coach_problem_on_coach_id"
    t.index ["problem_id"], name: "index_coach_problem_on_problem_id"
  end

  create_table "coaches", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "age"
    t.integer "gender"
    t.text "about"
    t.text "experience"
    t.text "licenses"
    t.text "education"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "coach_id"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_id"], name: "index_invitations_on_coach_id"
    t.index ["user_id"], name: "index_invitations_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "problems", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "technique_id"
    t.integer "like"
    t.integer "dislike"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["technique_id"], name: "index_ratings_on_technique_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "coach_id"
    t.bigint "technique_id"
    t.integer "status"
    t.integer "step"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_id"], name: "index_recommendations_on_coach_id"
    t.index ["technique_id"], name: "index_recommendations_on_technique_id"
    t.index ["user_id"], name: "index_recommendations_on_user_id"
  end

  create_table "socials", force: :cascade do |t|
    t.text "title"
    t.bigint "coach_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["coach_id"], name: "index_socials_on_coach_id"
  end

  create_table "steps", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "number"
    t.bigint "technique_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["technique_id"], name: "index_steps_on_technique_id"
  end

  create_table "technique_problem", id: false, force: :cascade do |t|
    t.bigint "technique_id"
    t.bigint "problem_id"
    t.index ["problem_id"], name: "index_technique_problem_on_problem_id"
    t.index ["technique_id"], name: "index_technique_problem_on_technique_id"
  end

  create_table "techniques", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "age"
    t.integer "gender"
    t.integer "total_steps"
    t.string "duration"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_problem", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "problem_id"
    t.index ["problem_id"], name: "index_user_problem_on_problem_id"
    t.index ["user_id"], name: "index_user_problem_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "age"
    t.integer "gender"
    t.text "about"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "socials", "coaches"
  add_foreign_key "steps", "techniques"
end
