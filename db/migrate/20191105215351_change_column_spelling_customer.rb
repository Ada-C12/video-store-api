class ChangeColumnSpellingCustomer < ActiveRecord::Migration[5.2]
  def change
    rename_column(:customers, :registred_at, :registered_at)
  end
end
