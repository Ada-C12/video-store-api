require "test_helper"

describe CustomersController do
  describe "index" do
    it "responds with JSON and success" do
      get customers_path
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "responds with an array of customer hashes" do
      # Act
      get customers_path
      
      # Get the body of the response
      body = JSON.parse(response.body)
      
      # Assert
      expect(body).must_be_instance_of Array
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal KEYS
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
    it "will show customer info for valid customer" do
      test_customer = customers(:customer_one)
      get customer_path(test_customer)
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      must_respond_with :ok
      expect(body.keys.sort).must_equal KEYS
      
      expect(body["id"]).must_equal test_customer.id
      expect(body["name"]).must_equal test_customer.name
      expect(body["address"]).must_equal test_customer.address
      expect(body["city"]).must_equal test_customer.city
      expect(body["state"]).must_equal test_customer.state
      expect(body["postal_code"]).must_equal test_customer.postal_code
      expect(body["phone"]).must_equal test_customer.phone
      expect(body["registered_at"]).must_equal test_customer.registered_at
      expect(body["movies_checked_out_count"]).must_equal test_customer.movies_checked_out_count
    end
    
    it "will show error code for invalid customer" do
      invalid_customer = -1
      get customer_path(invalid_customer)
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["not found"]
      must_respond_with :not_found
    end
    
  end
end
