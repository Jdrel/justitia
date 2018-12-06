class DeleteHourlyRateFromLawyers < ActiveRecord::Migration[5.2]
  def change
    remove_column :lawyers, :hourly_rate
  end
end
