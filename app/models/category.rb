class Category < ApplicationRecord
  has_many :specialties
  CATEGORIES = ['Corporate', 'Employment', 'Finance', 'Intellectual Property', 'Family', 'Tax', 'Criminal Defense', 'Traffic', 'Personal Injury', 'Digital Media & Internet', 'Immigration', 'Real Estate', 'Other']

  def get_category_names_alphabetically_ordered
    @category_names = []
    Category.all.each do |category|
      @category_names << category.name
    end
    @category_names.sort_by!{ |c| c.downcase }
    @category_names.insert(0,"All categories")
    return @category_names
  end
end
