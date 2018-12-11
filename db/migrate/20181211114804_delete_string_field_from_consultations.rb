class DeleteStringFieldFromConsultations < ActiveRecord::Migration[5.2]
  def change
    remove_column :consultations, :string
  end
end
