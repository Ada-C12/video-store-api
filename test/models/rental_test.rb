require "test_helper"

describe Rental do
  let(:rental) {
    rentals(:one)
  }

  let(:customer) {
    customers(:one)
  }

  let(:movie) {
    movies(:croods)
  }

  describe "relationships" do
    describe "relationship with Customer" do
      it "belongs to Customer and can set the customer_id through customer" do
        new_rental = Rental.new(movie_id: movie.id)
        new_rental.customer = customer
        new_rental.save
        expect(new_rental.customer).must_be_instance_of Customer
        expect(new_rental.customer_id).must_equal customer.id
      end

      it "can set the customer through customer_id" do
        new_rental = Rental.new(movie_id: movie.id)
        new_rental.customer_id = customer.id
        new_rental.save
        expect(new_rental.customer).must_be_instance_of Customer
      end
    end

    describe "relationship with Movie" do
      it "belongs to Movie and can set the movie_id through movie" do
        new_rental = Rental.new(customer_id: customer.id)
        new_rental.movie = movie
        new_rental.save
        expect(new_rental.movie).must_be_instance_of Movie
        expect(new_rental.movie_id).must_equal movie.id
      end

      it "can set the movie through movie_id" do
        new_rental = Rental.new(customer_id: customer.id)
        new_rental.movie_id = movie.id
        new_rental.save
        expect(new_rental.movie).must_be_instance_of Movie
      end
    end
  end

  describe "custom methods" do
    describe "setup_dates" do
      it "will setup the check out and check in dates" do
        rental.setup_dates

        expect(rental.check_out).must_equal Date.today
        expect(rental.check_in).must_equal Date.today + 7
      end
    end

    describe "rental overdue" do
      it "changes the is_overdue status to true" do
        rental = rentals(:one)

        rental.rental_overdue

        expect(rental.is_overdue).must_equal true
      end

      it "doesn't change the is_overdue status" do
        rental = rentals(:two)

        rental.rental_overdue

        expect(rental.is_overdue).must_equal false
      end
    end
  end
end
