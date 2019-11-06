require "test_helper"

describe Customer do
  before do 
    @customer = customers(:c1)
  end
  
  describe "relations" do
    it "can have one or many rentals" do
      @customer.must_respond_to :rentals
      @customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end    
  end
end
