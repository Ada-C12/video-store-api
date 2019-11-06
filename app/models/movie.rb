class Movie < ApplicationRecord
  has_many :rentals, dependent: :destroy
  validates_format_of :release_date, with: /\d{4}-\d{2}-\d{2}/, on: [:create, :update], message: "Release Date Must Use Format YYYY-MM-DD"
  
  def as_json(*)
    super.except("created_at", "updated_at").tap do |hash|
      hash["available_inventory"] = self.inventory
    end
  end
  
end
