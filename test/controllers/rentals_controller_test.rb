require "test_helper"

describe RentalsController do
  describe "checkout" do
    before do
      @new_rental = {
        rental: {
          customer_id: customers(:customer1).id,
          movie_id: movies(:movie1).id
        }
      }
    end
    
    it "can create a new rental and responds with created status" do
      expect { post checkout_path, params: @new_rental }.must_differ "Rental.count", 1
      
      must_respond_with :ok
      
      body = JSON.parse(response.body)
      expect(body.keys).must_include 'id'
    end
    
    it "responds with bad_request when request fails validation (no customer)" do
      @new_rental[:rental][:customer_id] = nil
      
      expect { post checkout_path, params: @new_rental }.wont_change "Rental.count"
      
      must_respond_with :bad_request
      
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body['errors']).must_equal ["Customer not found"]
    end
  end
  
  describe "checkin" do
    
  end
end
