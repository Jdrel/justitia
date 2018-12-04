class Lawyer < ApplicationRecord
  belongs_to :user
  has_many :consultations, dependent: :destroy
  has_many :specialties, dependent: :destroy
end
