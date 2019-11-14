require "test_helper"

describe Customer do
  before do 
    @customer = customers(:one)
  end 
  
  describe "validations" do 
    
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
  
  describe "relationships" do 
    it "can have many rentals" do 
      expect(@customer.rentals.count).must_equal 2
    end 
    
    it "can have customers" do 
      expect(@customer.movies.count).must_equal 2
    end 
    
    it "cannot have any movies without rentals" do 
      Rental.destroy_all
      expect(@customer.movies).must_be_empty
    end 
    
    it "can exist without customers" do 
      Rental.destroy_all
      Movie.destroy_all
      result = @customer.valid?
      expect(result).must_equal true 
    end 
    
    it "can exist without any rentals" do 
      Rental.destroy_all 
      result = @customer.valid?
      expect(result).must_equal true 
    end 
  end 
end
