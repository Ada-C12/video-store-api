require "test_helper"

describe Customer do
  describe "validations" do 
    before do 
      @customer = Customer.create(name: "Beep", registered_at: '1999-01-01 00:00', address: "822 Lake St", city: "Seattle", state: "WA", postal_code: "98112", phone:"323-322-5466")
    end 
      
    it "is valid when all fields are present" do 
      result = @customer.valid?
      expect(result).must_equal true
    end 

    it "is invalid without a name" do 
      @customer.name = nil 
      result = @customer.valid?
      expect(result).must_equal false
    end 

    it "is invalid without a registered at date" do
      @customer.registered_at = nil 
      refute(@customer.valid?)
    end 
    
    it "is invalid without an address" do 
      @customer.address = nil 
      refute(@customer.valid?)
    end 

    it "is invalid without a city" do
      @customer.city = nil 
      refute(@customer.valid?)
    end 

    it "is invalid without a state" do 
      @customer.state = nil 
      refute(@customer.valid?)
    end 

    it "is invalid without a postal code" do 
      @customer.postal_code = nil 
      refute(@customer.valid?)
    end 

    it "is invalid without a phone" do
      @customer.phone = nil 
      refute(@customer.valid?) 
    end 

  end 
end
