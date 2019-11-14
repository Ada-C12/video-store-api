class ChangeColumnNamesCustomerPostalCodePhone < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :zip_code, :postal_code
    rename_column :customers, :phone_num, :phone
  end
end
