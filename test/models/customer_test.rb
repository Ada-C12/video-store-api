require "test_helper"

describe Customer do
  describe "relations" do
    let(:current_customer) { customers(:customer1)}

    it "can get the list of rentals from 'rentals'" do
      expect(current_customer.rentals.length).must_equal 2
      expect(current_customer.rentals[0]).must_be_instance_of Rental
      expect(current_customer.rentals[0].customer).must_equal customers(:customer1)
    end
  end

  describe "validations" do 

    it "is invalid without a name" do 
      customer = customers(:customer1)
      customer.name = nil

      result = customer.valid?

      expect(result).must_equal false
    end

    it "is valid with a name" do 
      customer = customers(:customer1)

      result = customer.valid?

      expect(result).must_equal true
    end
  end
end
