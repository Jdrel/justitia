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

require 'nokogiri'
require 'open-uri'

photos = []
url = 'https://www.gettyimages.in/photos/lawyer-portraits?mediatype=photography&phrase=lawyer%20portraits&sort=mostpopular'
html_file = open(url).read
html_doc = Nokogiri::HTML(html_file)
html_doc.search('.srp-asset-image').each do |element|
  photos << element.attribute('src').value
end

Category::CATEGORIES.each do |category|
  Category.create(
    name: category
  )
end

seed_categories = Category.all

puts 'Creating 10 fake lawyer...'

15.times do
  full_name = Faker::GameOfThrones.character
  user = User.create(
    first_name: full_name.split.first,
    last_name: full_name.split.last,
    address: Faker::GameOfThrones.city,
    email: Faker::Internet.email,
    password: 'secret'
  )
  lawyer = Lawyer.create(
    user: user,
    description: Faker::GameOfThrones.quote,
    years_of_experience: rand(0..45),
    hourly_rate_cents: rand(3000..50000),
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: photos.sample,
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
