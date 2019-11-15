require "test_helper"

describe CustomersController do
  describe "index" do
    it "responds with JSON, success, and an array of customer hashes" do
      get customers_path
      body = check_response(expected_type: Array)
      body.each do |customer|
        expect(customer).must_be_instance_of Hash
        expect(customer.keys.sort).must_equal CUSTOMER_KEYS.sort
      end
    end
  end
  
  it "will respond with an empty array when there are no customers" do
    Customer.destroy_all
    get customers_path
    body = check_response(expected_type: Array)
    expect(body).must_equal []
  end
end
