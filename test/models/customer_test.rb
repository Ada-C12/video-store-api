require "test_helper"

describe Customer do
  let (:customer) {customers(:c1)}
  
  describe "validations" do
    
    it "is valid with all fields present and valid" do
      expect(customer.valid?).must_equal true
    end
    
    it "is invalid without a name" do
      customer.name = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :name
    end
    
    it 'is invalid without a name' do
      invalid_customer = Customer.create(name: "wolfy")
      
      expect(invalid_customer.valid?).must_equal false
      expect(invalid_customer.errors.messages).must_include :name
    end
    
    it 'is invalid without an complete address' do
      customer.address = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :address
    end
    
    it 'is invalid without an address' do
      invalid_customer = customer.create(name: "new customer", address: "12456 Seawall Lane")
      
      expect(invalid_customer.valid?).must_equal false
      expect(invalid_customer.errors.messages).must_include :address
    end
    
    
    it 'is invalid when registered_at is not complete' do
      customer.registered_at = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :registered_at
    end
    
    it 'is invalid without an registered_at timestamp' do
      invalid_customer = customer.create(name: "new customer", registered_at: "Wed, 05 Nov 2019 07:54:15 -0700")
      
      expect(invalid_customer.valid?).must_equal false
      expect(invalid_customer.errors.messages).must_include :registered_at
    end
    
    it 'is invalid without a city' do
      customer.registered_at = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :city
    end
    
    it 'is invalid without a complete city' do
      invalid_customer = customer.create(name: "new customer", city: "Cleaveland")
      
      expect(invalid_customer.valid?).must_equal false
      expect(invalid_customer.errors.messages).must_include :city
      
      
      it 'is invalid without a state' do
        customer.registered_at = nil
        
        expect(customer.valid?).must_equal false
        expect(customer.errors.messages).must_include :state
      end
      
      it 'is invalid without a complete state' do
        invalid_customer = customer.create(name: "new customer", state: "Ohio")
        
        expect(invalid_customer.valid?).must_equal false
        expect(invalid_customer.errors.messages).must_include :state
      end
      
      it 'is invalid without a postal_code' do
        customer.registered_at = nil
        
        expect(customer.valid?).must_equal false
        expect(customer.errors.messages).must_include :postal_code
      end
      
      it 'is invalid without a complete postal_code' do
        invalid_customer = customer.create(name: "new customer", postal_code: "91208")
        
        expect(invalid_customer.valid?).must_equal false
        expect(invalid_customer.errors.messages).must_include :postal_code
      end
      
      it 'is invalid without a phone' do
        customer.registered_at = nil
        
        expect(customer.valid?).must_equal false
        expect(customer.errors.messages).must_include :phone
      end
      
      it 'is invalid without a complete phone' do
        invalid_customer = customer.create(name: "new customer", phone: "719-322-2819")
        
        expect(invalid_customer.valid?).must_equal false
        expect(invalid_customer.errors.messages).must_include :phone
      end
    end
    
    describe "relations" do
      it "can have one or many rentals" do
        @customer.must_respond_to :rentals
        @customer.rentals.each do |rental|
          rental.must_be_kind_of rental
        end
      end    
    end
  end
end