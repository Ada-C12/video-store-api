require "test_helper"

describe Customer do
  let (:new_customer) { customers(:one) }
  describe "validations" do
    it "is a valid customer" do
      assert(new_customer.valid?)
    end

    it "requires all fields" do
      required_fields = [:name, :address, :city, :state, :postal_code, :phone]

      required_fields.each do |field|
        new_customer[field] = nil

        expect(new_customer.valid?).must_equal false

        new_customer.reload
      end
    end
  end

  describe "relationships" do
    it "has a list of rentals" do
      new_customer.must_respond_to :rentals
      new_customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end
end
