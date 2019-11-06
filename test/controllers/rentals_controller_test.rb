require "test_helper"

describe RentalsController do
  before do
    @movie = Movie.create(title: "valid movie", inventory: 10, available_inventory: 10)
    @customer = Customer.create(name: "valid customer")
  end

  describe "checkout" do
    it "can checkout a movie by creating a new rental with valid input and available inventory" do
      
      expect{ 
        post checkout_path, params: {movie_id: @movie.id, customer_id: @customer.id} 
      }.must_change "Rental.count", 1
      
      must_respond_with :created
    end
    
    it "will not create rental without available inventory" do
      @movie.update(available_inventory: 0)
      
      expect{ 
        post checkout_path, params: {movie_id: @movie.id, customer_id: @customer.id} 
      }.wont_change "Rental.count"
      
      must_respond_with :bad_request
    end
  end
  
  describe "checkin" do
    it "can checkin a valid rental and  by creating a new rental with valid input and available inventory" do
      # check out rental so that it can be checked in
      post checkout_path, params: {movie_id: @movie.id, customer_id: @customer.id}
      
      expect{ 
        patch checkin_path, params: {movie_id: @movie.id, customer_id: @customer.id} 
      }.wont_change "Rental.count"
      
      must_respond_with :ok
    end
    
    it "will not checkin a rental that doesn't exist" do
      expect{ 
        patch checkin_path, params: {id: -1} 
      }.wont_change "Rental.count"
      
      must_respond_with :not_found
    end
  end
end
