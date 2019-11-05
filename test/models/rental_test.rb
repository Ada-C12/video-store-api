require "test_helper"

describe Rental do
  let(:new_rental) {
    new_rental = Rental.new(
      checkout_date: Time.new(2018, 1, 1),
      due_date: Time.new(2018, 1, 7),
      movie: movies(:movie1),
      customer: customers(:customer1),
    )
  }

  describe "instantiation" do
    it "can instantiate a valid rental" do
      expect(new_rental.save).must_equal true
    end
  end
  
  describe "relationships" do
    it "belongs to a movie" do
      rental = Rental.new(
        checkout_date: Time.new(2018, 1, 1),
        due_date: Time.new(2018, 1, 7),
        customer: customers(:customer1),
      )
      movie_1 = movies(:movie1)
      rental.movie = movie_1
      expect(rental.movie.title).must_equal movie_1.title
    end

    it "belongs to a customer" do
      rental = Rental.new(
        checkout_date: Time.new(2018, 1, 1),
        due_date: Time.new(2018, 1, 7),
        movie: movies(:movie1),
      )
      customer_1 = customers(:customer1)
      rental.customer = customer_1
      expect(rental.customer.name).must_equal customer_1.name
    end
  end

  describe "validations" do
    it "needs a due date" do
      new_rental.due_date = nil
      expect(new_rental.valid?).must_equal false
      expect(new_rental.errors.messages).must_include :due_date
      expect(new_rental.errors.messages[:due_date]).must_include "can't be blank"
    end
  end

end
