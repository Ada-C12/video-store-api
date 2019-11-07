require "test_helper"

describe CustomersController do
  
  describe "index" do
    let(:customer_keys) {[:id, :name, :registered_at, :postal_code, :phone, :movies_checked_out_count]}
    it "responds with JSON and success" do
      get customers_path
      
      check_response(expected_type: Array)
      must_respond_with :ok
    end
    
    it "responds with customer data" do
      get customers_path
      
      body = check_response(expected_type: Array)
      
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal customer_keys.sort
      end
    end
    
    it "will respond with an empty array when there are no customers" do
      Customer.destroy_all
      get customers_path
      
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end
end
