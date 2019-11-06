class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy
  validates_format_of :release_date, with: /\d{4}-\d{2}-\d{2}/, on: [:create, :update], message: "Release Date Must Use Format YYYY-MM-DD"
  
  def available_inventory
    rentals = self.rentals
    checked_out_rentals = []
    
    rentals.each do |rental|
      if rental.due_date != nil
        checked_out_rentals << rental
      end
    end
    
    return self.inventory - checked_out_rentals.count
  end
  
  def as_json(*)
    super.except("created_at", "updated_at").tap do |hash|
      hash["available_inventory"] = available_inventory
    end
  end
  
end
