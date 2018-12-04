# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
User.destroy_all
Lawyer.destroy_all
Category.destroy_all
Specialty.destroy_all

Category::CATEGORIES.each do |category|
  Category.create(
    name: category
  )
end

seed_categories = Category.all

response = RestClient.get "https://randomuser.me/api/"
url = JSON.parse(response)

puts 'Creating 1 fake lawyers...'

1.times do
  user = User.create(
    first_name: Faker::Friends.character.split.first,
    last_name: Faker::Friends.character.split.last,
    address: Faker::WorldCup.city,
    email: Faker::Internet.email,
    password: 'secret'
  )
  lawyer = Lawyer.create(
    user: user,
    description: Faker::Friends.quote,
    years_of_experience: rand(0..45),
    hourly_rate: rand(30..500),
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: url['results'][0]['picture']['large'],
    stripe_token: Faker::String.random(12),
    stripe_id: rand(0..999)
  )
  rand(1..3).times do
    lawyer.specialties.create!(
      lawyer: lawyer,
      category: seed_categories.sample
    )
  end
end

puts 'Finished!'
