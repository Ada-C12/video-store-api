require "test_helper"

describe Rental do
  
  describe "validation" do
    it "must have a customer and movie" do
      movie = Movie.create(title: "valid movie")
      customer = Customer.create(name: "valid customer")
      rental = Rental.create(movie_id: movie.id, customer_id: customer.id)
      
      is_valid = rental.valid?
      
      assert(is_valid)
    end
    it "returns invalid if no customer is present" do
      movie = Movie.create(title: "valid movie")
      rental = Rental.create(movie_id: movie.id)
      
      is_valid = rental.valid?
      
      refute(is_valid)
    end
    it "returns invalid if no movie is present" do
      customer = Customer.create(name: "valid customer")
      rental = Rental.create(customer_id: customer.id)
      
      is_valid = rental.valid?
      
      refute(is_valid)
    end
    
  end
  
  describe "relationships" do
    before do
      @movie = Movie.create(title: "valid movie")
      @customer = Customer.create(name: "valid customer")
      @rental = Rental.create(movie_id: @movie.id, customer_id: @customer.id)
    end
    it "must belong to a customer" do
      @rental.must_respond_to :customer
      @rental.customer.must_be_kind_of Customer
    end
    it "must belong to a movie" do
      @rental.must_respond_to :movie
      @rental.movie.must_be_kind_of Movie
    end
  end
end
