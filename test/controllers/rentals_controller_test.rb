require "test_helper"
require 'pry'

describe RentalsController do
  describe "index" do
    it "responds with JSON and success" do
      get rentals_path
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "responds with an array of rental hashes" do
      # Act
      get rentals_path
      
      # Get the body of the response
      body = JSON.parse(response.body)
      
      # Assert
      expect(body).must_be_instance_of Array
      body.each do |rental|
        expect(rental).must_be_instance_of Hash
        expect(rental.keys.sort).must_equal RENTAL_KEYS.sort
      end
    end
    
    it "will respond with an empty array when there are no rentals" do
      # Arrange
      Rental.destroy_all
      
      # Act
      get rentals_path
      body = JSON.parse(response.body)
      
      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end
  describe "show" do
    it "will show rental info for valid rental" do
      rental = Rental.first
      get rental_path(rental)
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      # must_respond_with :ok
      # expect(body.keys.sort).must_equal @KEYS
      
      expect(body["id"]).must_equal rental.id
      expect(body["customer_id"]).must_equal rental.customer.id
      expect(body["movie_id"]).must_equal rental.movie.id
      expect(body["checkout_date"]).must_equal rental.checkout_date.to_s
      expect(body["due_date"]).must_equal rental.due_date.to_s
    end
    
    it "will show error code for invalid rental" do
      invalid_rental = -1
      get rental_path(invalid_rental)
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["not found"]
      must_respond_with :not_found
    end
  end
  
  describe "create" do
    let(:rental_data) {
      {
        movie_id: Movie.first.id,
        customer_id: Customer.first.id,
        checkout_date: Time.now,
        due_date: (Time.now + 5)
      }
    }
    
    it "can create a new rental" do
      expect {
        post rentals_path, params: rental_data
      }.must_differ 'Rental.count', 1
      
      must_respond_with :created
    end
    
    it "will return the correct info for new rental" do
      rental = Rental.last
      get rental_path(rental)
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      # must_respond_with :ok
      # expect(body.keys.sort).must_equal @KEYS
      
      expect(body["id"]).must_equal rental.id
      expect(body["customer_id"]).must_equal rental.customer.id
      expect(body["movie_id"]).must_equal rental.movie.id
      expect(body["checkout_date"]).must_equal rental.checkout_date.to_s
      expect(body["due_date"]).must_equal rental.due_date.to_s
    end
  end
  
  describe "checkout" do
    it "can create a new rental" do
      customer = customers(:customer_one)
      movie = movies(:movie_one)
      expect {
        post checkout_path
      }.must_differ 'Rental.count', 1
      
      must_respond_with :created
    end
  end
  
  describe "checkin" do
    it "can return a movie" do
      customer = customers(:customer_one)
      movie = movies(:movie_one)
      expect {
        post checkout_path
      }.must_differ 'Rental.count', -1
      
      must_respond_with :updated
    end
  end
end

