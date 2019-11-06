require "test_helper"

describe CustomersController do
  let(:customer1) { customers(:customer1) }
  describe "index" do
    it "responds with an array of customer hashes" do
      get customers_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal ["id", "name", "phone", "postal_code", "registered_at"]
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
end
