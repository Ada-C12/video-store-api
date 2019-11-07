require "test_helper"

describe RentalsController do
  describe "checkin" do
    let(:rental_data) {
      {
          customer_id: customers(:eminique).id,
          movie_id: movies(:titanic).id,
        }
    }
    
    it "responds with JSON and success when passed in valid params" do
      post checkout_path, params: rental_data

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
  
  end
end
