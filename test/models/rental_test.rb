require "test_helper"

describe Rental do
  before do 
    @rental = Rental.new(
      checkout_date: Date.today,
      due_date: Date.today + 7,
      movie_id: movies(:movie2).id,
      customer_id: customers(:customer3).id
    )
  end

  describe "initialize" do
    it "can create a new rental with checkout_date is today and due_date is 7 days from today and returned is false" do
      new_rental = Rental.new(customer_id: customers(:customer3).id, movie_id: movies(:movie2).id)

      expect _(new_rental.checkout_date).must_equal Date.today
      expect _(new_rental.due_date).must_equal Date.today + 7
      expect _(new_rental.returned).must_equal false
    end
  end

  describe "validations" do
    it "is valid when all fields are present" do
      result = @rental.valid?

      expect(result).must_equal true
    end

    it "is invalid without a checkout_date" do
      @rental.checkout_date = nil
      result = @rental.valid?

      expect(result).must_equal false
    end

    it "is invalid without a due_date" do
      @rental.due_date = nil
      result = @rental.valid?

      expect(result).must_equal false
    end

    it "is invalid without a movie" do
      @rental.movie_id = nil
      result = @rental.valid?

      expect(result).must_equal false
    end

    it "is invalid without a customer" do
      @rental.customer_id = nil
      result = @rental.valid?

      expect(result).must_equal false
    end
  end

  describe "relationship" do
    it "can have one movie and one customer" do
      @rental.save

      rental = Rental.first

      expect(rental.movie).must_be_instance_of Movie
      expect(rental.customer).must_be_instance_of Customer
    end
  end
end
