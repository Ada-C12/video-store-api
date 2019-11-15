require "test_helper"

describe Customer do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe "instantiation" do
    it "can instantiate a valid customer" do
      customer = Customer.new(name: "Patrick Starr", address: "1234 Rock Lane", city: "Bikini Bottom", state: "Ocean", postal_code: "12345", phone: "1234567890")
      expect(customer.save).must_equal true
    end
  end

  describe "relationships" do
    it "can have many rentals" do
      movie = movies(:movie1)
      customer = customers(:customer1)
      rental_1 = Rental.new(movie: movie, checkout_date: Time.new(2018, 1, 1), due_date: Time.new(2018, 1, 7))
      rental_2 = Rental.new(movie: movie, checkout_date: Time.new(2018, 1, 1), due_date: Time.new(2018, 1, 7))
      rental_3 = Rental.new(movie: movie, checkout_date: Time.new(2018, 1, 1), due_date: Time.new(2018, 1, 7))

      customer.rentals << rental_1
      customer.rentals << rental_2
      customer.rentals << rental_3

      expect(customer.rentals.count).must_be :>, 1

      customer.rentals.each do |rental|
        expect(rental).must_be_instance_of Rental
      end
    end
  end

  describe "validation" do
    it " must have a name" do
      customer = customers(:customer1)
      customer.name = nil
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :name
      expect(customer.errors.messages[:name]).must_include "can't be blank"
    end
    it " must have a postal code" do
      customer = customers(:customer1)
      customer.postal_code = nil
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :postal_code
      expect(customer.errors.messages[:postal_code]).must_include "can't be blank"
    end
  end
end
