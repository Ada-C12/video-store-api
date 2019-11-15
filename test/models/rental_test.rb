require "test_helper"

describe Rental do
  describe "relations" do
    before do
      @rental = rentals(:rental1)
    end
    
    it "belongs to a movie" do
      expect(@rental.movie).must_be_instance_of Movie
    end
    
    it "belongs to a customer" do
      expect(@rental.customer).must_be_instance_of Customer
    end
  end
  
  describe "validations" do
    before do
      movie = Movie.first
      customer = Customer.first
      @rental = Rental.create(movie_id: movie.id, customer_id: customer.id)
    end
    
    it "is valid when all fields are present" do
      expect(@rental.valid?).must_equal true
    end
    
    it "is not valid when movie is missing" do
      @rental.movie_id = nil
      
      expect(@rental.valid?).must_equal false
    end
    
    it "is not valid when customer is missing" do
      @rental.customer_id = nil
      
      expect(@rental.valid?).must_equal false
    end
  end
end
