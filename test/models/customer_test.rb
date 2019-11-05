require "test_helper"

describe Customer do
  describe "validations" do
    let(:customer) {customers(:customer_one)}
    
    it "can be created" do
      expect(customer.valid?).must_equal true
    end
    
    it "requires name, postal_cost, registered_at" do
      required_fields = [:name, :postal_code, :registered_at]
      
      required_fields.each do |field|
        customer[field] = nil
        
        expect(customer.valid?).must_equal false
        
        customer.reload
      end
    end 
  end
end
