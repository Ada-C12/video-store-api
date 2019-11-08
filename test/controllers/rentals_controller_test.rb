require "test_helper"

describe RentalsController do
  let(:customer) { customers(:one) }
  let(:movie) { movies(:one) }
  let(:rental) { 
    {
      customer_id: customer.id,
      movie_id: movie.id
    }
  }
  
  describe "check_out" do
    it "responds with JSON and success, creates a new rental" do
      
      expect(customer.movies_checked_out_count).must_equal 0
      expect(movie.available_inventory).must_equal 12
      
      expect {
        post check_out_path, params: rental
      }.must_differ 'Rental.count', 1
      
      
      body = JSON.parse(response.body)
      
      expect(response.header['Content-Type']).must_include 'json'
      expect(body["id"]).must_be_instance_of Integer
      must_respond_with :ok
      
    end 
    
    it "responds with a bad request when customer id is nil" do
      bad_rental = {
        customer_id: nil,
        movie_id: movie.id,
      }
      
      expect {
        post check_out_path, params: bad_rental
      }.must_differ 'Rental.count', 0
      
      must_respond_with :bad_request
      
      body = JSON.parse(response.body)
      
      expect(body["errors"]).must_equal "Invalid customer or movie ID!"
      
    end
    
    it 'responds with bad request when movie doesnt have available inventory' do 
      bad_movie = movies(:four)
      bad_rental = {
        customer_id: customer.id,
        movie_id: bad_movie.id,
      }
      
      expect {
        post check_out_path, params: bad_rental
      }.must_differ 'Rental.count', 0
      
      must_respond_with :bad_request
      
      body = JSON.parse(response.body)
      
      expect(body["errors"]).must_equal "No available inventory"
    end
  end
  
  describe "check_in" do
    it "responds with JSON and success, checks back in a rental" do
      
      post check_out_path, params: rental
      
      expect {
        post check_in_path, params: rental
      }.must_differ 'Rental.count', 0
      body = JSON.parse(response.body)
      
      expect(customer.movies_checked_out_count).must_equal 0
      expect(movie.available_inventory).must_equal 12
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    
    it "responds with a bad request when customer id is invalid" do
      bad_rental = {
        customer_id: 9999999999,
        movie_id: movie.id,
      }
      
      expect {
        post check_in_path, params: bad_rental
      }.must_differ 'Rental.count', 0
      
      must_respond_with :bad_request
      
      body = JSON.parse(response.body)
      
      expect(body["errors"]).must_equal "Invalid customer or movie ID!"
      
    end
  end
end