class RenameStatusToAppointmentStatus < ActiveRecord::Migration[5.2]
  def change
    rename_column :consultations, :status, :appointment_status
  end
end
