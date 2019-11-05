require "test_helper"

describe Customer do
  describe "validations" do
    let(:customer){customers(:bob)}
    
    it "must have a name" do
      customer.name = nil
      
      refute customer.valid?
      expect(customer.errors.messages).must_include :name
      expect(customer.errors.messages[:name]).must_include "can't be blank"
    end
    
    it "must have a registration date" do
      customer.registered_at = nil
      
      refute customer.valid?
      expect(customer.errors.messages).must_include :registered_at
      expect(customer.errors.messages[:registered_at]).must_include "can't be blank"
    end
    
    it "must have an address" do
      customer.address = nil
      
      refute customer.valid?
      expect(customer.errors.messages).must_include :address
      expect(customer.errors.messages[:address]).must_include "can't be blank"
    end
    
    it "must have a city" do
      customer.city = nil
      
      refute customer.valid?
      expect(customer.errors.messages).must_include :city
      expect(customer.errors.messages[:city]).must_include "can't be blank"
    end
    
    it "must have a state" do
      customer.state = nil
      
      refute customer.valid?
      expect(customer.errors.messages).must_include :state
      expect(customer.errors.messages[:state]).must_include "can't be blank"
    end
    
    it "must have a postal code" do
      customer.postal_code = nil
      
      refute customer.valid?
      expect(customer.errors.messages).must_include :postal_code
      expect(customer.errors.messages[:postal_code]).must_include "can't be blank"
    end
    
    it "must have a phone number" do
      customer.phone = nil
      
      refute customer.valid?
      expect(customer.errors.messages).must_include :phone
      expect(customer.errors.messages[:phone]).must_include "can't be blank"
    end
  end
end
