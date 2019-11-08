require "test_helper"

describe RentalsController do
  describe "checkout" do 
    it "should respond with JSON, created, & store a rental in the db for an existing customer and movie" do
      checkout_params = { customer_id: customers(:shelley).id, movie_id: movies(:first).id }

      expect {
        post checkout_path, params: checkout_params
    }.must_change "Rental.count", 1

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    
    end

    it "should respond with bad_request if customer doesn't exist and won't change the db" do
      checkout_params = { customer_id: -1, movie_id: movies(:first).id }

      expect {
        post checkout_path, params: checkout_params
    }.wont_change "Rental.count"

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :bad_request

      response_body = JSON.parse(response.body)
      expect(response_body["errors"]["customer"]).must_equal ["must exist"]
    end

    it "should respond with bad_request if movie doesn't exist and won't change the db" do
      checkout_params = { customer_id: customers(:shelley).id, movie_id: -1 }

      expect {
        post checkout_path, params: checkout_params
    }.wont_change "Rental.count"

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :bad_request
      
      response_body = JSON.parse(response.body)

      expect(response_body["errors"]["movie"]).must_equal ["must exist"]
    end
  end

  describe "checkin" do
    it "wont_change the db and responds ok for an existing customer and movie" do
      checkin_params = { customer_id: customers(:shelley).id, movie_id: movies(:first).id }

      expect {
        post checkin_path, params: checkin_params
    }.wont_change "Rental.count"

      must_respond_with :ok
    end

    it "should respond with bad_request if customer or movie doesn't exist and won't change the db" do
      available_inventory = movies(:first).available_inventory
      checkin_params = { customer_id: -1, movie_id: movies(:first).id }

      expect {
        post checkin_path, params: checkin_params
      }.wont_change "Rental.count"

      expect(movies(:first).available_inventory).must_equal available_inventory

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :bad_request

      response_body = JSON.parse(response.body)
      expect(response_body["errors"]["rental"]).must_equal "not found"
    end
  end
end
