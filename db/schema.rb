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

ActiveRecord::Schema.define(version: 2021_05_27_063957) do

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.boolean "correct"
    t.integer "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "exam_questions", force: :cascade do |t|
    t.integer "question_id"
    t.integer "exam_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_id", "question_id"], name: "index_exam_questions_on_exam_id_and_question_id", unique: true
    t.index ["exam_id"], name: "index_exam_questions_on_exam_id"
    t.index ["question_id"], name: "index_exam_questions_on_question_id"
  end

  create_table "exams", force: :cascade do |t|
    t.integer "time"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "subject_id"
    t.index ["user_id"], name: "index_exams_on_user_id"
  end

  create_table "question_types", force: :cascade do |t|
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "type_id"
    t.integer "subject_id"
    t.index ["subject_id"], name: "index_questions_on_subject_id"
    t.index ["type_id"], name: "index_questions_on_type_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "value"
    t.integer "time"
    t.integer "subject_id", null: false
    t.integer "exam_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_id"], name: "index_results_on_exam_id"
    t.index ["subject_id"], name: "index_results_on_subject_id"
    t.index ["user_id"], name: "index_results_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tops", force: :cascade do |t|
    t.integer "sorces_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sorces_id"], name: "index_tops_on_sorces_id"
  end

  create_table "user_answers", force: :cascade do |t|
    t.integer "exam_question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "content"
    t.integer "result_id"
    t.boolean "correct"
    t.integer "answers_id"
    t.index ["answers_id"], name: "index_user_answers_on_answers_id"
    t.index ["exam_question_id"], name: "index_user_answers_on_exam_question_id"
    t.index ["result_id"], name: "index_user_answers_on_result_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "gender"
    t.integer "age"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.boolean "admin_role", default: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "remember_token"
    t.integer "school_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "exam_questions", "exams"
  add_foreign_key "exam_questions", "questions"
  add_foreign_key "exams", "users"
  add_foreign_key "results", "exams"
  add_foreign_key "results", "subjects"
  add_foreign_key "results", "users"
  add_foreign_key "tops", "results", column: "sorces_id"
  add_foreign_key "user_answers", "answers", column: "answers_id"
  add_foreign_key "user_answers", "exam_questions"
  add_foreign_key "user_answers", "results"
  add_foreign_key "users", "schools"
end
