class AddArrivalTimeOfParticipants < ActiveRecord::Migration[5.2]
  def change
    add_column :consultations, :client_arrival_time, :datetime
    add_column :consultations, :lawyer_arrival_time, :datetime
  end
end
