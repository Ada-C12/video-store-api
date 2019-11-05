class RemoveColumnRegisteredAtCustomers < ActiveRecord::Migration[5.2]
  def change
    remove_column :customers, :registered_at
  end
end
