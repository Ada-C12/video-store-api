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
        expect{
          @rental.checkout
        }.must_change @rental.movie.available_inventory, -1

      end

      it "should increment the number of movies checked out for a customer" do
        expect{
          @rental.checkout
        }.must_change @rental.customer.movies_checked_out_count, 1
      end

      it "returns true when when checkout is successful" do
        expect{
          @rental.checkout
        }.must_equal true
      end

      it "returns false when checking out an unavailable movie" dolk,

      end
    end

    describe 'checkin' do

    end
  end
end
