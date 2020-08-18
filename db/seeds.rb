# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
  User.create(name: i + 1, password: i + 1)
end

10.times do |i|
  Question.create(question: "単語#{i + 1}", description: "単語#{i + 1}の回答")
  QuestionSimilar.create(question_id: i + 1, similar_word: "単語#{i + 1}の類似語1")
  QuestionSimilar.create(question_id: i + 1, similar_word: "単語#{i + 1}の類似語2")
end