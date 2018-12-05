class Lawyer < ApplicationRecord
  belongs_to :user
  has_many :consultations, dependent: :destroy
  has_many :specialties, dependent: :destroy
  def categories
    categories_names = []
    self.specialties.each do |specialty|
      categories_names << specialty.category.name
    end
    categories_names_string = categories_names.join(", ")
    return categories_names_string
  end
end
