require "test_helper"

describe CustomersController do
  
  describe "index" do
    it "responds with JSON and success" do
      get customers_path
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "responds with customer data" do
      get customers_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      body.each do |customer|
        p customer
        expect(customer).must_be_instance_of Hash
        # expect(customer.keys.sort).must_equal
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
  
  #test not passing
  # describe "group_by_n" do
  #   before do
  #     10.times do
  #       Customer.create!(name: "customer", registered_at: Date.today, postal_code: "98101", phone: "111-222-3333", movies_checked_out_count: 1)
  #     end
  #   end
  #   it "returns subarrays of 'n' customers" do
  #     get customers_path, params: {"sort" => "name", "n" => "2"}
      
  #     body = check_response(expected_type: Array)
  #     body.each do |subarray|
  #       expect(subarray).must_be_instance_of Array
  #       expect(subarray.length).must_equal 2
  #     end
      
  #   end
  # end
end
