class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.datetime :requested_at
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_num

      t.timestamps
    end
  end
end
