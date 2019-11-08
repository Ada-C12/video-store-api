require "test_helper"

describe RentalsController do
  let(:rental_data) {
    {
      movie_id: movies(:croods).id,
      customer_id: customers(:one).id,
    }
  }
  describe "checkout" do
    it "can create a rental" do
      expect {
        post checkout_path, params: rental_data
      }.must_differ "Rental.count", 1
      
      must_respond_with :ok
    end
    
    it "responds with JSON" do
      post checkout_path, params: rental_data
      expect(response.header["Content-Type"]).must_include "json"
    end
    
    it "responds with an array of movie hashes" do
      post checkout_path, params: rental_data
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal ["customer_id", "movie_id"].sort
    end
    
    it "will return a bad request if stock is unavailable" do
      movie = movies(:croods)
      
      movie.available_inventory = 0
      movie.save
      
      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      
      expect(response.header["Content-Type"]).must_include "json"
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal "Stock unavailable!"
    end
    
    it "will return a bad_request if rental cannot be created" do
      rental_data[:movie_id] = nil
      
      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      
      expect(response.header["Content-Type"]).must_include "json"
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "movie"
    end
  end
  
  describe "checkin" do
    it "can find the existing rental" do
      expect {
        post checkin_path, params: rental_data
      }.wont_change "Rental.count"
      must_respond_with :ok
    end
    
    it "responds with JSON" do
      post checkin_path, params: rental_data
      expect(response.header["Content-Type"]).must_include "json"
    end
    
    it "responds with an array of rental hashes" do
      post checkin_path, params: rental_data
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal ["customer_id", "movie_id"].sort
    end
    
    it "responds with bad_request and an error message if no rental is found" do
      Rental.destroy_all
      expect {
        post checkin_path, params: rental_data
      }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      expect(response.header["Content-Type"]).must_include "json"
      
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal "Rental is not found!"
    end
  end
  
  describe "overdue" do 
    it "responds with JSON and success" do 
      get overdue_path
      
      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :ok
    end
    
    it "responds with an array of overdue rental hashes" do
      get overdue_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      
      body.each do |rental|
        expect(rental).must_be_instance_of Hash
        expect(rental.keys.sort).must_equal ["movie_id", "title", "customer_id", "name", "postal_code", "checkout_date", "due_date"].sort
      end
    end
    
    it "responds with a message in an array if there are no overdue rental found" do
      Rental.destroy_all
      get overdue_path
      
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body.keys).must_include "messages"
      assert_equal body['messages'], "No overdue rental is found!"
    end
  end
end