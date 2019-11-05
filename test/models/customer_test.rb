require "test_helper"

describe Customer do
  describe "validations" do
    
    before do 
      @valid_customer = Customer.first
    end
    
    it "checks to see if fixtures are sticking" do
      #also checks peripherally (sp) that the customers are valid 
      num = Customer.all.count
      expect(num).must_equal 4
    end
    
    it "customer is invalid if name is missing" do
      @valid_customer.name = ""
      refute(@valid_customer.valid?)
    end
    
    it "customer is invalid if registered_at (time of creation) is missing" do
      @valid_customer.registered_at = ""
      refute(@valid_customer.valid?)
    end
    
    it "customer's registered_at must be instance of dateime" do
      @valid_customer.registered_at = "bananas"
      refute(@valid_customer.valid?)
    end
    
    it "customer's registered_at must be instance of dateime" do
      valid_date_time = DateTime.now
      @valid_customer.registered_at = valid_date_time
      assert(@valid_customer.valid?)
    end
    
    it "customer is invalid if postal code is missing" do
      @valid_customer.postal_code = ""
      refute(@valid_customer.valid?)
    end
    
    it "customer is invalid if phone number is missing" do
      @valid_customer.phone = ""
      refute(@valid_customer.valid?)
    end
    
  end
end
