class CreateConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :consultations do |t|
      t.references :client, foreign_key: true
      t.references :lawyer, foreign_key: true
      t.integer :duration
      t.monetize :lawyer_amount
      t.jsonb :lawyer_payment
      t.monetize :client_amount
      t.jsonb :client_payment
      t.string :status
      t.string :string
      t.timestamps
    end
  end
end
