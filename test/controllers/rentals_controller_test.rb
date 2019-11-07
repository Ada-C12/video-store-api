require "test_helper"

describe RentalsController do
  describe "checkout" do 
    before do 
      movie = movies(:blacksmith)
      customer = Customer.first
      @rental = {
        movie_id: movie.id, 
        customer_id: customer.id
      }
    end
    
    it "can create a new rental" do
      
      expect {
        post checkout_path, params: @rental
      }.must_differ 'Rental.count', 1
      
      # inventory = Rental.last.movie.available_inventory
      
      must_respond_with :ok
      body = JSON.parse(response.body)
      expect(body.keys).must_equal (['id'])
      
      rental = Rental.find_by(id: body["id"])
      expect(rental.movie.available_inventory).must_equal ((movies(:blacksmith).available_inventory) - 1)
      
    end
    
    it "will respond with bad_request for invalid data" do
      # Arrange - using let from above
      @rental[:movie_id] = nil
      expect {
        # Act
        post checkout_path, params: @rental
        # Assert
      }.wont_change "Rental.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "movie"
    end
    
    it "gives a valid checkout date" do
      expect {
        post checkout_path, params: @rental
      }.must_differ 'Rental.count', 1
      must_respond_with :ok
      body = JSON.parse(response.body)
      
      rental = Rental.find_by(id: body["id"])
      expect(rental.checkout_date).must_equal Date.today
    end
    
    it "gives a due date 7 days after the checkout date" do
      expect {
        post checkout_path, params: @rental
      }.must_differ 'Rental.count', 1
      must_respond_with :ok
      body = JSON.parse(response.body)
      
      rental = Rental.find_by(id: body["id"])
      expect(rental.due_date).must_equal (Date.today + 7.days)
    end
  end
  
  describe "checkin" do 
    before do 
      @movie = movies(:blacksmith)
      customer = Customer.first
      @rental = {
        movie_id: @movie.id, 
        customer_id: customer.id
      }
    end
    
    it "can assign a checkin_date and change available_inventory" do
      post checkout_path, params: @rental
      
      inventory = Rental.last.movie.available_inventory
      
      expect {
        post checkin_path, params: @rental
      }.wont_change 'Rental.count'
      
      body = JSON.parse(response.body)
      must_respond_with :ok
      rental = Rental.find_by(id: body["id"])
      expect(rental.movie.available_inventory).must_equal (inventory + 1)
      expect(rental.checkin_date).must_equal Date.today
    end
    
    it "will respond with bad_request for invalid data" do
      # Arrange - using let from above
      @rental[:movie_id] = nil
      expect {
        # Act
        post checkin_path, params: @rental
        # Assert
      }.wont_change "Rental.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"]).must_equal "This rental does not exist"
    end
  end
end
