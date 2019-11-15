require "test_helper"

describe Customer do
  describe "validations" do
   it "is valid when there is a name" do
    customer = Customer.new(name: "lois")
    expect(customer.valid?).must_equal true
   end

   it "is invalid when there is not a name" do
    customer = customers(:dora)
    customer.name = nil
    expect(customer.valid?).must_equal false
   end
  end

  describe "relationships" do
    it "can add a movie through rentals" do
      new_customer = Customer.new(name: "ada")
      new_customer.movies << movies(:movie1)
      _(new_customer.movies.first.id).must_equal movies(:movie1).id
    end

    it "can have many rentals" do
      valid_customer = customers(:janice)
      expect(valid_customer.rentals.count).must_equal 2
      valid_customer.rentals.each do |rental|
        _(rental).must_be_kind_of Rental
      end

    end
  end


end
