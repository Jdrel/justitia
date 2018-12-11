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

  def calculate_client_amount
    rate = lawyer.calculate_5mins_rate
    minutes = duration_to_minutes
    five_minutes_block = (minutes / 5).abs
    (rate * five_minutes_block + rate) * 100
  end
end
