class ChangeColumnNameCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :requested_at, :registered_at
  end
end
