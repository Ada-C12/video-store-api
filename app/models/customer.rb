class Customer < ApplicationRecord
  has_many :rentals, dependent: :destroy
  
  def movies_checked_out_count
    return self.rentals.count
  end
  
  
  #https://blog.arkency.com/how-to-overwrite-to-json-as-json-in-active-record-models-in-rails/
  def as_json(*)
    super.except("created_at", "updated_at").tap do |hash|
      hash["movies_checked_out_count"] = movies_checked_out_count
    end
  end
  
end
