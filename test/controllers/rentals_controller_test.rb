require "test_helper"

describe RentalsController do
  before do
    @rental = {
      rental: {
        customer_id: customers(:customer1).id,
        movie_id: movies(:movie1).id
      }
    }
  end
  describe "checkout" do
    it "can create a new rental and responds with ok status" do
      expect { post checkout_path, params: @rental }.must_differ "Rental.count", 1
      
      must_respond_with :ok
      
      body = JSON.parse(response.body)
      expect(body.keys).must_include 'id'
    end
    
    it "responds with bad_request when request fails validation (no customer)" do
      @rental[:rental][:customer_id] = nil
      
      expect { post checkout_path, params: @rental }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body['errors']).must_equal ["Customer not found"]
    end
  end
  
  describe "checkin" do
    it "can update a new rental and responds with ok status" do
      post checkout_path, params: @rental
      expect { post checkin_path, params: @rental }.wont_differ "Rental.count"
      
      must_respond_with :ok
      
      body = JSON.parse(response.body)
      expect(body.keys).must_include 'id'
    end

    it "responds with bad_request when request fails validation (no customer)" do
      @rental[:rental][:customer_id] = nil
      
      post checkin_path, params: @rental
      
      must_respond_with :bad_request
      
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body['errors']).must_equal ["Customer not found"]
    end
  end
end
