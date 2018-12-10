class Consultation < ApplicationRecord
  belongs_to :client
  belongs_to :lawyer

  monetize :client_amount_cents

  def duration_to_minutes
    duration / 60
  end

  def end_time
    start_time + duration
  end
end
