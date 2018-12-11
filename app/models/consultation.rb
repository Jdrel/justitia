class Consultation < ApplicationRecord
  belongs_to :client
  belongs_to :lawyer

  monetize :client_amount_cents

  def duration_to_minutes
    duration / 60
  end

  def duration_to_units
    minutes = duration_to_minutes
    (minutes / 5) + 1
  end

  def end_time
    start_time + duration
  end

  def calculate_client_amount
    rate = lawyer.calculate_5mins_rate
    five_minutes_units = duration_to_units
    rate * five_minutes_units
  end
end
