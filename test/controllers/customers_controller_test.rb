require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = ['id', 'name', 'phone', 'postal_code', 'registered_at']

  describe "index" do 
    it "responds with JSON and success" do
      get customers_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "will give a list of all customers" do
      get customers_path

      body = JSON.parse(response.body)
  
      expect(body).must_be_instance_of Array
      expect(body.size).must_equal Customer.count

      body.each do |pet_hash| 
        expect(pet_hash).must_be_instance_of Hash
        expect(pet_hash.keys.sort).must_equal CUSTOMER_FIELDS
      end 
    end
  end 
 
end
