class AddPaymentStatusToConsultation < ActiveRecord::Migration[5.2]
  def change
    add_column :consultations, :payment_status, :string, default: 'pending'
  end
end
