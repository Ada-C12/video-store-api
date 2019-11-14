require "test_helper"

describe CustomersController do
  CUSTOMERS_INDEX_FIELDS = %w(id movies_checked_out_count name phone postal_code registered_at)
  CUSTOMER_SHOW_FIELDS = %w(address city id movies_checked_out_count name phone postal_code registered_at state)

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
        expect(customer.keys.sort).must_equal CUSTOMERS_INDEX_FIELDS
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
      
      get customer_path(customer.id)
      body = check_response(expected_type: Hash)
      
      expect(body.keys.sort).must_equal CUSTOMER_SHOW_FIELDS
    end 
    
    it "sends back not_found if customer doesn't exist" do 
      get customer_path(-100)
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body.keys).must_include "errors"
    end 
  end
end 
