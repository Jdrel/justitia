class Lawyer < ApplicationRecord
  belongs_to :user
  has_many :consultations
  has_many :specialities
end
