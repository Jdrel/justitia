# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Cleaning database...'
Lawyer.destroy_all
Client.destroy_all
User.destroy_all
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

puts 'Creating 10 lawyers...'

10.times do |i|
  first_name = Faker::Name.first_name
  user = User.create(
    first_name: first_name,
    last_name: Faker::Name.last_name,
    address: Faker::WorldCup.city,
    email: "#{first_name}#{i.to_s}@justitia.today",
    password: 'secret'
  )
  lawyer = Lawyer.create(
    user: user,
    description: Faker::GameOfThrones.quote,
    years_of_experience: rand(0..45),
    hourly_rate_cents: rand(3000..50000),
    is_first_consultation_free: Faker::Boolean.boolean,
    is_online: Faker::Boolean.boolean,
    photo: photos.sample
  )
  rand(1..3).times do
    lawyer.specialties.create!(
      lawyer: lawyer,
      category: seed_categories.sample
    )
  end
  i += 1
end

puts 'Creating 10 users...'

10.times do |i|
  first_name = Faker::Name.first_name
  user = User.create(
    first_name: first_name,
    last_name: Faker::Name.last_name,
    address: Faker::WorldCup.city,
    email: "#{first_name}#{i.to_s}@justitia.today",
    password: 'secret'
  )
  Client.create(
    user: user
  )
  i += 1
end

puts 'Finished!'
