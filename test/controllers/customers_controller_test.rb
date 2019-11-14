require "test_helper"

describe CustomersController do

  describe "index" do
    it "responds with JSON, success, and an array of customer hashes" do
      # Act
      get customers_path
      
      # check_response confirms success, header includes json, and keys in json
      body = check_response(expected_type: Array)
      
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal ["address", "city", "id", "movies_checked_out_count", "name", "phone", "postal_code", "registered_at", "state"]
      end
    end
    
    it "will respond with an empty array when there are no customers" do
      # Arrange
      Customer.destroy_all
      
      # Act 
      get customers_path

      # Assert 
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

end
