class SetDefaultConsultationStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :consultations, :appointment_status, from: nil, to: 'pending'
  end
end
