class Lawyer < ApplicationRecord
  belongs_to :user
  has_many :consultations, dependent: :destroy
  has_many :specialties, dependent: :destroy
  monetize :hourly_rate_cents

  def calculate_5mins_rate
    hourly_rate * 0.0833
  end
end
