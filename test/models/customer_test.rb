require "test_helper"

describe Customer do 
  describe "initialize" do
    before do
      @new_customer = Customer.new(name: "Janice")
    end

    it "can be instantiated" do
      expect(@new_customer.valid?).must_equal true
    end
    
    it "will have the required fields" do
      CUSTOMER_KEYS.each do |field|
        expect(@new_customer).must_respond_to field
      end
    end
  end

  describe "validations" do
    describe "name" do
      it "must have a name" do
        customer_one = customers(:one)
        customer_one.name = nil
        
        expect(customer_one.valid?).must_equal false
        expect(customer_one.errors.messages).must_include :name
        expect(customer_one.errors.messages[:name]).must_equal ["can't be blank"]
      end
    end
  end
end
