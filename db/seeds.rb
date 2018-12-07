puts 'Cleaning database...'
Client.destroy_all
Lawyer.destroy_all
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

10.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::WorldCup.city,
    email: 'justitia.ninjas@gmail.com',
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
  Client.create(
    user: user
  )
  end
end

puts 'Creating 10 users...'

10.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    address: Faker::WorldCup.city,
    email: 'justitia.ninjas@gmail.com',
    password: 'secret'
  )
  Client.create(
    user: user
  )
end

puts 'Finished!'
