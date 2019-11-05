require "test_helper"

describe Rental do
  describe "validations" do
    let(:rental) {rentals(:rental_one)}
    
    it "can be created" do
      expect(rental.valid?).must_equal true
    end
    
    it "requires checkout_date, due_date, customer, movie" do
      required_fields = [:customer_id, :movie_id, :checkout_date, :due_date]
      
      required_fields.each do |field|
        rental[field] = nil
        
        expect(rental.valid?).must_equal false
        
        rental.reload
      end
    end 
  end
end
