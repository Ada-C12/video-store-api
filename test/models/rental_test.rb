require "test_helper"

describe Rental do
  let(:customer) { customers(:one) }
  let(:movie) { movies(:one) }
  let(:rental) { 
    {
      customer_id: customer.id,
      movie_id: movie.id
    }
  }
  describe "relations" do
    it "belongs to a movie" do
      r = rentals(:rental_one)
      r.must_respond_to :movie_id
      r.movie_id.must_be_kind_of Integer
    end
    
    it "belongs to a customer" do
      r = rentals(:rental_one)
      r.must_respond_to :customer_id
      r.customer_id.must_be_kind_of Integer
    end
  end
  
  describe "check_out" do
    before do
      new_rental = Rental.check_out(customer, movie)
    end
    
    it "decrements the inventory of a movie if inventory is greater than 0" do
      expect(movie.available_inventory).must_equal 11
    end
    
    it "does not decrement the inventory of a movie if inventory is less than 1" do
      movie.available_inventory = 0
      expect(movie.available_inventory).must_equal 0
    end
    
    it "increments the number of movies a customer has checked out" do
      expect(customer.movies_checked_out_count).must_equal 1
    end
  end
end