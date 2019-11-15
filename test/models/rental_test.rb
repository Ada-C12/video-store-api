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

  describe "custom methods" do
    describe "checkout_movie" do
      it "will reduce the inventory for a movie by 1 and increase the count for a customers checked out movies count by 1" do 
        movie_1 = movies(:movie1)
        customer_1 = customers(:customer1)
        rental = Rental.create(
          checkout_date: Time.new(2018, 1, 1),
          due_date: Time.new(2018, 1, 7),
          movie: movie_1,
          customer: customer_1,
        )

        rental.checkout_movie
        expect(movie_1.inventory).must_equal 9
        expect(customer_1.movies_checked_out_count).must_equal 5
      end

      it "if movie isn't available won't reduce the inventory for a movie and won't increase the count for a customers checked out movies" do
        movie_1 = movies(:movie1)
        movie_1.inventory = 0
        customer_1 = customers(:customer1)

        rental = Rental.create(
          checkout_date: Time.new(2018, 1, 1),
          due_date: Time.new(2018, 1, 7),
          movie: movie_1,
          customer: customer_1,
        )

        rental.checkout_movie
        expect(movie_1.inventory).must_equal 0
        expect(customer_1.movies_checked_out_count).must_equal 4
      end
    end

    describe "checkin_movie" do
      it "will increase the inventory for a movie by 1 and decrease the count for a customers checked out movies count by 1" do 
        movie_1 = movies(:movie1)
        customer_1 = customers(:customer1)
        rental = Rental.create(
          checkout_date: Time.new(2018, 1, 1),
          due_date: Time.new(2018, 1, 7),
          movie: movie_1,
          customer: customer_1,
        )

        rental.checkout_movie
        rental.checkin_movie
        expect(movie_1.inventory).must_equal 10
        expect(customer_1.movies_checked_out_count).must_equal 4
      end
    end

  end

end
