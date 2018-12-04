class Category < ApplicationRecord
  has_many :specialties
  CATEGORIES = ['Corporate', 'Employment', 'Finance', 'Intellectual Property', 'Family', 'Tax', 'Criminal Defense', 'Traffic', 'Personal Injury', 'Digital Media & Internet', 'Immigration', 'Real Estate', 'Other']
end
