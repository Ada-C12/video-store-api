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
      customer.name = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :name
    end
    
    it 'is invalid without address' do
      customer.address = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :address
    end
    
    
    it 'is invalid when registered_at timestamp' do
      customer.registered_at = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :registered_at
    end
    
    it 'is invalid without a city' do
      customer.city = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :city
    end
    
    it 'is invalid without a state' do
      customer.state = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :state
    end
    
    it 'is invalid without a postal_code' do
      customer.postal_code = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :postal_code
    end
    
    it 'is invalid without a phone' do
      customer.phone = nil
      
      expect(customer.valid?).must_equal false
      expect(customer.errors.messages).must_include :phone
    end
    
  end
  
  describe "relations" do
    it "can have one or many rentals" do
      
      customer.must_respond_to :rentals
      customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end    
    end
  end
end
