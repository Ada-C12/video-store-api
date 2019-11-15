require "test_helper"

describe Customer do
  let (:customer) {customers(:shelley)}
  
  describe "validations" do
    it "can be created" do
      expect(customer.valid?).must_equal true
    end
  end
  
  describe "relations" do
    it "has a list of rentals" do
      _(customer).must_respond_to :rentals
      customer.rentals.each do |rental|
        _(rental).must_be_kind_of Rental
      end
    end
    
    it "can have no rentals" do
      _(customers(:curran).rentals.length).must_equal 0
    end
  end
end
