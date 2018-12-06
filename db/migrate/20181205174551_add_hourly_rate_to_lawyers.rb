class AddHourlyRateToLawyers < ActiveRecord::Migration[5.2]
  def change
    add_monetize :lawyers, :hourly_rate
  end
end
