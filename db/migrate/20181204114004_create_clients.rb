class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.references :user, foreign_key: true
      t.string :stripe_token
      t.integer :stripe_id

      t.timestamps
    end
  end
end
