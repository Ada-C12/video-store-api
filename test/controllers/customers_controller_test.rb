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
        p customer
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
  
  describe "group_by_n" do
    before do
      10.times do
        Customer.create!(name: "customer", registered_at: Date.today, postal_code: "98101", phone: "111-222-3333", movies_checked_out_count: 1)
      end
    end
    it "returns subarrays of 'n' customers" do
      get customers_path, params: { sort: "name", n: "2" }
      
      body = check_response(expected_type: Array)
      body.each do |subarray|
        expect(subarray).must_be_instance_of Array
        expect(subarray.length).must_equal 2
      end
    end
    
    it "will respond with an error if given invalid 'p' params" do
      get customers_path, params: { sort: nil, n: "3", p: "40"}
      
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_include "not found"
    end
    
    it "will return all customers if given a 'p' param without an 'n' param" do
      get customers_path, params: { sort: nil, n: nil, p: "4"}
      
      check_response(expected_type: Array)
    end
  end
end
