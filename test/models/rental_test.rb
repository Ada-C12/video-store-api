require "test_helper"

describe Rental do
  let (:movie) {movie = Movie.create(title: "valid movie")}
  let (:customer) {customer = Customer.create(name: "valid customer")}
  
  describe "validation" do
    it "must have a customer and movie" do
      rental = Rental.create(movie_id: movie.id, customer_id: customer.id)
      
      is_valid = rental.valid?
      
      assert(is_valid)
    end
    it "returns invalid if no customer is present" do
      rental = Rental.create(movie_id: movie.id)
      
      is_valid = rental.valid?
      
      refute(is_valid)
    end
    it "returns invalid if no movie is present" do
      rental = Rental.create(customer_id: customer.id)
      
      is_valid = rental.valid?
      
      refute(is_valid)
    end
    
  end
  
  describe "relationships" do
    before do
      @rental = Rental.create(movie_id: movie.id, customer_id: customer.id)
    end

    it "must belong to a customer" do
      expect(@rental).must_respond_to :customer
      expect(@rental.customer).must_be_kind_of Customer
    end

    it "must belong to a movie" do
      expect(@rental).must_respond_to :movie
      expect(@rental.movie).must_be_kind_of Movie
    end
  end
  
  describe "custom methods" do    
    before do
      @movie = Movie.create(title: "valid movie", inventory: 10, available_inventory: 10)
      @customer = Customer.create(name: "valid customer")
      @rental = Rental.create(movie_id: @movie.id, customer_id: @customer.id)
    end
    
    describe "check out rental method" do
      it "decrements available inventory" do
        starting_inventory = @movie.available_inventory
        
        @rental.check_out_rental
        
        @movie.reload
        
        expect(@movie.available_inventory).must_equal starting_inventory - 1
      end
      
      it "increments movies checkout out count" do
        starting_checked_out = @customer.movies_checked_out_count
        
        @rental.check_out_rental
        
        @customer.reload
        
        expect(@customer.movies_checked_out_count
        ).must_equal starting_checked_out + 1
      end
    end
    
    describe "check in rental method" do
      it "increments available inventory" do
        starting_inventory = @movie.available_inventory
        
        @rental.check_in_rental
        
        @movie.reload
        
        expect(@movie.available_inventory).must_equal starting_inventory + 1
      end
      
      it "decrements movies checked out count" do
        starting_checked_out = @customer.movies_checked_out_count
        
        @rental.check_in_rental
        
        @customer.reload
        
        expect(@customer.movies_checked_out_count
        ).must_equal starting_checked_out - 1
      end
    end
    
  end
end
