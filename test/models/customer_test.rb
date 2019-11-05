require "test_helper"

describe Customer do
  describe "relationships" do
    it "can add a movie through rentals" do
      new_customer = Customer.new(name: "ada")
      new_customer.movies << movies(:movie1)
      new_customer.movies.first.id.must_equal movies(:movie1).id
    end

    it "can have many rentals" do
      valid_customer = customers(:janice)

      expect(valid_customer.rentals.count).must_equal 1
      valid_customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end

    end
  end


end
