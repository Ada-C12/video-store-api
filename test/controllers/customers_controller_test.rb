require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = ["id", "name", "registered_at", "postal_code", "phone", "movies_checked_out_count"]
  describe "index" do
    it "responds with JSON and success" do
      get customers_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
  end
end
