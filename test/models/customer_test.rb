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
  
  describe "relationships" do
    it "customer rentals are verifiable" do
      expected_rental = 2 #checked by hand based on yml
      customer = customers(:c_1)      
      expect(customer.rentals.count).must_equal expected_rental
    end
    
    it "customer without rentals does not have rentals" do
      expected_rental = 0
      customer = customers(:c_4)
      expect(customer.rentals.count).must_equal expected_rental
    end
  end
end
