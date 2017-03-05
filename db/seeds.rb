# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying old records"

Survey.destroy_all
Question.destroy_all
Choice.destroy_all

puts "Old records destroyed"

3.times do
	s = Survey.new
	s.title = Faker::Lorem.sentence
	s.description = Faker::Lorem.paragraph
	s.save!
end

10.times do
	q = Question.new
	q.text = Faker::Lorem.sentence
	q.required = (Faker::Number.between(1, 2) == 1) ? true : false
	q.num_choices = Faker::Number.between(3, 6)
	q.question_type = 'Multiple Choice'
	q.choice_type = (Faker::Number.between(1, 2) == 1) ? 'Just One' : 'Multiple'
	q.survey_id = (Faker::Number.between(1, 2) == 1) ? Survey.first.id : Survey.last.id
	q.save!
	q.num_choices.times do
		c = Choice.new
		c.text = Faker::Lorem.sentence
	end
end