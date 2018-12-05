class SetDefaultConsultationStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :consultations, :status, from: nil, to: 'pending'
  end
end
