class AddAppointmentTimeToConsultations < ActiveRecord::Migration[5.2]
  def change
    add_column :consultations, :appointment_time, :datetime
  end
end
