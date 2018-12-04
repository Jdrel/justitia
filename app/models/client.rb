class Client < ApplicationRecord
  belongs_to :user
  has_many :consultations, dependent: :destroy
end
