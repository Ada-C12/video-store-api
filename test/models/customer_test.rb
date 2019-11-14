require "test_helper"

describe Customer do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  describe "relations" do
    it "has a list of rentals" do
      princess_bride = movies(:bride)
      swamp_thing = movies(:swamp)
      customer = customers(:one)
      
      _(customer).must_respond_to :rentals
      customer.rentals.each do |rental|
        _(rental).must_be_kind_of Rental
      end
      
    end
  end
  
  describe "validations" do
    before do 
      @invalid_customer = Customer.create
    end
    
    it "creates a customer if all required columns are present" do
      
      expect{
        Customer.create(name: "Testy", registered_at: Time.now, address: "123 Main St.", city: "Anytown", state: "Alabama", postal_code: "12334", phone: "218-332-1234")
      }.must_differ "Customer.count", 1
      
    end
    
    it "won't create a customer if name and registered_at are missing" do
      _(@invalid_customer.valid?).must_equal false
      _(@invalid_customer.errors.messages).must_include :name
      _(@invalid_customer.errors.messages).must_include  :registered_at
    end
    
    it "won't create a customer unless address, city, state, and postal code are provided" do
      _(@invalid_customer.valid?).must_equal false
      _(@invalid_customer.errors.messages).must_include :address
      _(@invalid_customer.errors.messages).must_include :city
      _(@invalid_customer.errors.messages).must_include :state
      _(@invalid_customer.errors.messages).must_include :postal_code
    end
    
    it "won't create a customer if phone isn't provided" do
      _(@invalid_customer.valid?).must_equal false
      _(@invalid_customer.errors.messages).must_include :phone
    end
    
  end
end
