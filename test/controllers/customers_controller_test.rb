CUSTOMER_KEYS_JSON = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone", "movies_checked_out_count"]

require "test_helper"


describe CustomersController do
  describe "index" do
    it "responds with JSON and success" do
      get customers_path
            
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "responds with an array of customer hashes" do
      get customers_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys).must_equal CUSTOMER_KEYS_JSON
      end
    end
    
    it "will respond with an empty array when there are no customers" do
      Customer.destroy_all
      
      get customers_path
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end  
  
  describe "show" do 
    it "responds with JSON and success" do
      customer = customers(:one)
      
      get customer_path(customer)
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "can find a valid customer" do
      customer = customers(:one)
      
      get customer_path(customer)
      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
      expect(body.keys).must_equal CUSTOMER_KEYS_JSON
      expect(body["name"]).must_equal "Dani"
      expect(body["id"]).must_equal customer.id
    end
    
    it "returns not found error if invalid customer" do
      invalid_id = -1
      get customer_path(invalid_id)
      
      body = JSON.parse(response.body)
      
      must_respond_with :not_found 
      expect(body["errors"]).must_equal ["not found"]     
    end
  end
  
  describe "create" do
    let(:customer_info) {
      {
        customer: {
          name: 'Tom'
        }
      }
    }
    it "responds with JSON and created status" do
      
      post customers_path, params: customer_info 
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :created
    end
    
    it "can create a new valid customer" do
      
      expect { post customers_path, params: customer_info }.must_differ 'Customer.count', 1
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      expect(body.keys).must_equal ["id", "name"]
      expect(body["name"]).must_equal "Tom"
    end 

    it "will respond with bad_request for invalid data" do
      customer_info[:customer][:name] = nil
      
      expect { post customers_path, params: customer_info }.wont_change "Customer.count"
      body = JSON.parse(response.body)
      
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      expect(body["errors"].keys).must_include "name"
    end
  end
end
