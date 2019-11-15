require "test_helper"

describe CustomersController do
  # constant for keys
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "postal_code", "phone", "movies_checked_out_count"].sort
  
  # describe "zomg" do
  #   it "checks to see if zomg produces zombies? :D" do
  #     success_statement = "It works!!"
  #     get test_path
  #     must_respond_with :ok
  #     expect(response.header['Content-Type']).must_include 'json'
  #     body = JSON.parse(response.body)
  #     expect(body).must_be_instance_of Hash 
  #     expect(body["statement"]).must_equal success_statement
  #   end
  # end
  
  describe "index" do
    it "returns JSON, success, and a list of customers" do
      # the route
      get customers_path
      
      # check that the content type of the header is JSON
      # check the response code
      # check that the body is a list
      body = check_response(expected_type: Array, expected_status: :ok)
      # check that the list contains hashes
      # check that the customer hash has the right keys
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS
      end
      # check length of list against Customer.all.count
      customer_count = Customer.all.count
      expect(body.length).must_equal customer_count
    end
    
    it "returns JSON, success, and an empty list if no customers" do
      Rental.destroy_all
      # delete all customers
      Customer.destroy_all
      
      # the route
      get customers_path
      
      # check that the content type of the header is JSON
      # check the response code
      # check that the body is a list
      body = check_response(expected_type: Array, expected_status: :ok)
      # check that the list contains hashes
      # check that the customer hash is empty
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.empty?).must_equal true
      end
      # check length of list against Customer.all.count
      customer_count = Customer.all.count
      expect(body.length).must_equal customer_count
    end
  end
  
end
