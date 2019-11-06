require "test_helper"

describe CustomersController do
  describe "index" do 
    it "responds with JSON and success" do 
      # Act
      get customers_path

      # Assert
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    CUSTOMER_FIELDS = ["address", "city", "id", "movies_checked_out_count", "name", "phone", "postal_code", "registered_at", "state"]

    it "responds with an array of customer hashes" do 
      # Act
      get customers_path 
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array 
      expect(body[0]).must_be_instance_of Hash 
    end

    it "will respond with an empty array if there are no customers" do 
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
end
