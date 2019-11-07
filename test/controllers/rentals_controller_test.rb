require "test_helper"

describe RentalsController do
  describe "checkout" do 
    before do 
      movie = Movie.first
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
      must_respond_with :ok
      body = JSON.parse(response.body)
      expect(body.keys).must_equal (['id'])
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
    
  end
end
