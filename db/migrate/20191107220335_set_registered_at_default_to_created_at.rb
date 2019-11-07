class SetRegisteredAtDefaultToCreatedAt < ActiveRecord::Migration[5.2]
  def self.up
    Customer.update_all("registered_at=created_at")
  end
  
  def self.down
  end
end
