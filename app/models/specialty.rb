class Specialty < ApplicationRecord
  belongs_to :lawyer
  belongs_to :category
end
