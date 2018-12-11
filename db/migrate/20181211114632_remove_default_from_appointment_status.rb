class RemoveDefaultFromAppointmentStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :consultations, :appointment_status, from: 'pending', to: nil
  end
end
