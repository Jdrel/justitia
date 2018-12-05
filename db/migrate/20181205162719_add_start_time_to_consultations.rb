class AddStartTimeToConsultations < ActiveRecord::Migration[5.2]
  def change
    add_column :consultations, :start_time, :datetime
  end
end
