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
        rental_two = Rental.create(customer: customers(:shelley), movie: movies(:second))
        
        rental.checkout
        refute rental_two.checkout
        expect(rental_two.errors[:availability]).must_equal ["can't check out a movie that is not in stock"]

      end
      
      it "should set the checkout date to today" do
        rental = Rental.create(customer: customers(:shelley), movie: movies(:first))

        rental.checkout
      
        today = Date.today

        expect(rental.checkout_date).must_equal today
      end

      it "should set the due date upon creation (equal to 7 days plus checkout date)" do
        rental = Rental.create(customer: customers(:shelley), movie: movies(:first))

        rental.checkout

        today = Date.today

        expect(rental.checkout_date).must_equal today
      
        next_week = (Date.today + 7)

        expect(rental.due_date).must_equal next_week 
      end
    end

    describe 'checkin' do

    end
  end

  describe 'validations' do
    describe 'available' do
      it 'is valid when movie has available inventory' do
        assert(rentals(:one).valid?(:checkout))
        expect(rentals(:one).errors).must_be_empty

      end

      it 'is invalid and returns errors when movie has no availability' do

      end
    end
  end
end
