require "test_helper"

describe CustomersController do
  describe "index" do
    it "response with JSON and success" do
      get customers_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with the expected list of customers" do
      get customers_path

      body = JSON.parse(response.body)
      expect _(body).must_be_instance_of Array
      expect _(body.size).must_equal Customer.count

      body.each do |customer_info|
        expect _(customer_info).must_be_instance_of Hash
        expect _(customer_info.keys.sort).must_equal ["id", "movies_checked_out_count", "name", "phone", "postal_code", "registered_at"]
      end
    end

    it "responds with the expected list of customers when there is no customer" do
      Customer.destroy_all
      get customers_path

      body = JSON.parse(response.body)
      expect _(body).must_be_instance_of Array
      expect _(body).must_be_empty
    end
  end
end
