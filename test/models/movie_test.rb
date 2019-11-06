require "test_helper"

describe Movie do
  describe "validations" do
    it "must be valid with title and non-negative integer inventory" do
    end

    it "must be invalid without title" do
    end

    it "must be invalid if the inventory is not an integer" do
    end

    it "must be invalid without inventory" do
    end

    it "must be invalid with a negative inventory" do
    end
  end

  describe "relations" do
    it "can add a customer through rentals" do
      customer = Customer.new(name: "Ada")
      movie = movies(:movie2)
      movie.customers << customer
      movie.customers.last.id.must_equal customer.id
    end

    it "can have many rentals" do
      cur_movie = movies(:movie1)
      expect(cur_movie.rentals.count).must_equal 2
      cur_movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end
  end
end
