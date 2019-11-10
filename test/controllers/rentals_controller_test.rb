require "test_helper"
# require "pry-rails"

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

describe RentalsController do
  
  describe "check out" do
    
    it "creates a new rental for an existing customer and available movie" do
      params = 
      {
        movie_id: movies(:bride).id,
        customer_id: customers(:one).id
      }

      expect{
        post checkout_path(params)
      }.must_differ "Rental.count", 1
      
      must_respond_with :success
      
    end
    
    it "responds with bad request for invalid data" do
      bogus_rental = 
      {
        movie_id: 0,
        customer_id: -99
      }
      
      expect {
        post checkout_path(bogus_rental)
      }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      
    end
    
    it "responds with bad request for movie with no available inventory" do 
      movie = movies(:swamp)
      movie.available_inventory = 0
      movie.save!
      
      unavailable_rental = 
      {
        movie_id: movie.id,
        customer_id: customers(:one).id
      }
      
      expect {
        post checkout_path(unavailable_rental)
      }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      
    end
    
  end
  
  
  describe "check in" do
    
    it "succeeds for an existing movie and customer" do
      movie = movies(:swamp)
      movie.available_inventory = 0
      movie.save!
      customer = customers(:one)
      
      params = 
      {
        movie_id: movie.id,
        customer_id: customer.id
      }
      
      expect{
        post checkin_path(params) 
      }.wont_change "Rental.count"
      
      must_respond_with :success
      
    end
    
    it "responds with bad request for a bogus movie and customer" do
      
    end
    
    it "responds with bad request when check in would make available inventory more than total inventory" do
      
    end
    
  end
  
end
