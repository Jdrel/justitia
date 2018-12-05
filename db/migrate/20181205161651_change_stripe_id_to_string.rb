class ChangeStripeIdToString < ActiveRecord::Migration[5.2]
  def change
    change_column :clients, :stripe_id, :string
  end
end
