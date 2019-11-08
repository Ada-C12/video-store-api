class Customer < ApplicationRecord
  has_many :rentals, dependent: :destroy
  
  def movies_checked_out_count
    rentals = self.rentals
    checked_out_rentals = []
    
    rentals.each do |rental|
      if rental.due_date != nil
        checked_out_rentals << rental
      end
    end
    
    return checked_out_rentals.length
  end
  
  
  #taken from https://blog.arkency.com/how-to-overwrite-to-json-as-json-in-active-record-models-in-rails/
  #it overwrites the as_json method to include the "movies_checked_out_count" key
  def as_json(*)
    super.except("created_at", "updated_at").tap do |hash|
      hash["movies_checked_out_count"] = movies_checked_out_count
    end
  end
  
end



