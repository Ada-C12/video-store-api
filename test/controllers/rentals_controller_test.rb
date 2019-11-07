require "test_helper"

describe RentalsController do
  describe "checkin" do
    let(:rental_data) {
      {
          customer_id: customers(:eminique).id,
          movie_id: movies(:titanic).id,
        }
    }
    
    it "responds with JSON and success when passed in valid params and creates new rental" do
      expect {
        post checkout_path, params: rental_data
      }.must_differ 'Rental.count', 1

      body = JSON.parse(response.body)
      
      expect(body["id"]).must_be_instance_of Integer
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
  end
end
