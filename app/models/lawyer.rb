class Lawyer < ApplicationRecord
  belongs_to :user
  has_many :consultations, dependent: :destroy
  has_many :specialties, dependent: :destroy
  has_many :categories, through: :specialties
  monetize :hourly_rate_cents

  def categories
    categories_names = []
    self.specialties.each do |specialty|
      categories_names << specialty.category.name
    end
    categories_names_string = categories_names.sort.uniq.join(", ")
    return categories_names_string
  end

  def calculate_5mins_rate
    hourly_rate * 0.0833
  end
end
