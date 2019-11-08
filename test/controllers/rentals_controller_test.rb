require "test_helper"

describe RentalsController do
  before do
    @movie = Movie.create(title: "valid movie", inventory: 10, available_inventory: 10)
    @customer = Customer.create(name: "valid customer")
  end
  
  describe "create (check out)" do
    it "can check out a movie by creating a new rental with valid input and available inventory" do
      expect{ 
        post checkout_path, params: {movie_id: @movie.id, customer_id: @customer.id} 
      }.must_change "Rental.count", 1

      created_rental = Rental.find_by(movie_id: @movie.id)
      
      expect(created_rental.checkout_date).must_be_kind_of Date
      expect(created_rental.due_date).must_be_kind_of Date

      body = check_response(expected_type: Hash)
      expect(body["id"]).must_equal created_rental.id
      must_respond_with :ok
    end
    
    it "will respond with error if invalid inventory" do
      @movie.update(available_inventory: 0)
      
      expect{ 
        post checkout_path, params: {movie_id: @movie.id, customer_id: @customer.id} 
      }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"]).must_include "unable to create rental"
    end

    it "will respond with error if invalid movie id" do      
      expect{ 
        post checkout_path, params: {movie_id: nil, customer_id: @customer.id} 
      }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"]).must_include "unable to create rental"
    end

    it "will respond with error if invalid cusotmer id" do      
      expect{ 
        post checkout_path, params: {movie_id: @movie.id, customer_id: nil} 
      }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"]).must_include "unable to create rental"
    end
  end
  
  describe "update (check in)" do
    it "can check in a valid rental and  by creating a new rental with valid input and available inventory" do
      # check out rental so that it can be checked in
      post checkout_path, params: {movie_id: @movie.id, customer_id: @customer.id}
      
      expect{ 
        patch checkin_path, params: {movie_id: @movie.id, customer_id: @customer.id} 
      }.wont_change "Rental.count"
      
      must_respond_with :ok
      check_response(expected_type: Hash)
    end
    
    it "will not check in a rental that doesn't exist" do
      expect{ 
        patch checkin_path, params: {id: -1} 
      }.wont_change "Rental.count"
      
      must_respond_with :not_found
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_include "rental not found"
    end
  end
  
  describe "overdue" do
    before do
      @movie = Movie.first
      @customer = Customer.first
      @rental = Rental.create(customer_id: @customer.id, movie_id: @movie.id)
      @rental.checkout_date = Date.today - 10
      @rental.due_date = Date.today - 3
      @rental.save!
    end
    
    it "returns all overdue rentals" do
      get overdue_path
      
      body = check_response(expected_type: Array)
      expect(body.length).must_equal Rental.count
      must_respond_with :ok
    end
    
    it "returns an empty array if there are no overdue rentals" do
      Rental.destroy_all
      
      get overdue_path
      
      body = check_response(expected_type: Array)
      expect(body.length).must_equal 0 
      must_respond_with :ok  
    end
  end
end
