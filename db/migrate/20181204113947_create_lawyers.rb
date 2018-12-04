class CreateLawyers < ActiveRecord::Migration[5.2]
  def change
    create_table :lawyers do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :address
      t.text :description
      t.integer :years_of_experience
      t.integer :hourly_rate
      t.boolean :is_first_consultation_free
      t.boolean :is_online
      t.string :stripe_token
      t.integer :stripe_id
      t.string :photo

      t.timestamps
    end
  end
end
