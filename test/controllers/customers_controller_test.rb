CUSTOMER_KEYS_JSON = ["id", "name", "registered_at", "address", "city", "state", "postal_code", "phone", "checked_out_count"]

require "test_helper"


describe CustomersController do
  describe "index" do
    it "responds with JSON and success" do
      get customers_path
      
      body = JSON.parse(response.body)
      
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
      # Arrange
      Customer.destroy_all
      
      # Act
      get customers_path
      body = JSON.parse(response.body)
      
      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end  
  
  describe "show" do 
    it "responds with JSON and success" do
      customer = customers(:one)
      
      get customer_path(customer)
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      expect(body.keys).must_equal CUSTOMER_KEYS_JSON
      expect(body["name"]).must_equal "Dani"
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
    it "can create a new customer" do
      expect { post customers_path, params: customer_info }.must_differ 'Customer.count', 1
      
      must_respond_with :created
    end
    
    it "will respond with bad_request for invalid data" do
      customer_info[:customer][:name] = nil
      
      expect { post customers_path, params: customer_info }.wont_change "Customer.count"
      
      must_respond_with :bad_request
      
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "name"
    end
  end
end
