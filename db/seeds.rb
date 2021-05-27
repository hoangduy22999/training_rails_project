require_relative '../lib/populator_fix.rb'

Question.populate 100 do |u|
  u.content = Faker::Food.dish
  u.type_id = 1
  u.subject_id = Subject.all.map { |sb| sb.id }.sample
  Answer.populate 4 do |a|
    a.question_id = u.id
    a.content = Faker::Food.dish
    a.correct = [true, false].sample
  end
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
