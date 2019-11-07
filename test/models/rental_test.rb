require "test_helper"

describe Rental do
  describe 'relations' do
    it 'belongs to a movie' do
      expect(rentals(:one)).must_respond_to(:movie)
      expect(rentals(:one).movie).must_be_instance_of Movie
    end 

    it 'belongs to a customer' do
      expect(rentals(:one)).must_respond_to(:customer)
      expect(rentals(:one).customer).must_be_instance_of Customer
    end
  end

  describe 'model methods' do

    describe 'checkout' do
      before do
        @rental = Rental.new(customer: customers(:shelley), movie: movies(:first))
      end

      it "should decrement the available inventory of movies" do
        movie_inventory = @rental.movie.available_inventory
        @rental.checkout

        expect(@rental.movie.available_inventory).must_equal movie_inventory - 1

      end

      it "should increment the number of movies checked out for a customer" do
        movies_checked_out_count = @rental.customer.movies_checked_out_count

        @rental.checkout

        expect(@rental.customer.movies_checked_out_count).must_equal movies_checked_out_count + 1
      end

      it "returns true when when checkout is successful" do
        assert @rental.checkout
      end

      it "returns false when checking out an unavailable movie" do
        rental = Rental.create(customer: customers(:shelley), movie: movies(:second))

        refute rentals(:two).checkout

      end
    end

    describe 'checkin' do

    end
  end
end
