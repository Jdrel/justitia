class CreateSpecialties < ActiveRecord::Migration[5.2]
  def change
    create_table :specialties do |t|
      t.references :lawyer, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
