class ChangeStripeIdToStringForLawyer < ActiveRecord::Migration[5.2]
  def change
    change_column :lawyers, :stripe_id, :string
  end
end
