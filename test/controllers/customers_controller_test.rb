require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = %w(address city id name phone postal_code registered_at state)
  
  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'
    
    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end
  
  describe "index" do
    it "responds with JSON and success" do
      get customers_path
      check_response(expected_type: Array)
    end 
    
    it "responds with an array of customers hashes" do
      get customers_path
      body = check_response(expected_type: Array)
      
      body.each do |customer|
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
    end
    
    it "will respond with an empty array when no customers" do
      Rental.destroy_all
      Customer.destroy_all
      
      get customers_path
      
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end 
  end
  
  describe "show" do
    it "retrieves one customer" do
      customer = Customer.first
      
      get customer_path(customer)
      body = check_response(expected_type: Hash)
      
      expect(body.keys.sort).must_equal CUSTOMER_FIELDS
    end 
    
    it "sends back not_found if customer doesn't exist" do 
      get customer_path(-100)
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body.keys).must_include "errors"
    end 
  end
  
  describe "create" do
    let(:customer_data) { 
    { 
    customer: {
    name: "lisa",
    address: "1250 3th Ave.",
    registered_at: Date.new(11-1-20),
    city: "Seattle",
    state: "WA",
    postal_code: "98102",
    phone: "313-444-4444"
  }
}
} 

it "can create a new customer" do
  expect {
  post customers_path, params: customer_data
}.must_differ "Customer.count", 1

body = check_response(expected_type: Hash, expected_status: :created)
new_customer = Customer.find(body["id"])

customer_data[:customer].each do |key, value|
  expect(new_customer[key.to_s]).must_equal value
end 
end

it "will respond with bad_request for invalid data" do
  customer_data[:customer][:name] = nil
  
  expect {
  post customers_path, params: customer_data
}.wont_change "Customer.count"

body = check_response(expected_type: Hash, expected_status: :bad_request)
expect(body["errors"].keys).must_include "name"
end 
end
end 
