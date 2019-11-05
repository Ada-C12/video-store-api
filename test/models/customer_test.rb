require "test_helper"

describe Customer do
  describe "relations" do
    let(:customer) { customers(:shelley) }
    let(:movie) {movies(:blacksmith)}
    let(:movie2) {movies(:savior)}
    
    it "can have many rentals" do
      Rental.create(movie_id: movie.id, customer_id: customer.id)
      Rental.create(movie_id: movie2.id, customer_id: customer.id)
      
      expect(customer.rentals.length).must_equal 2
    end
    
    it "can have zero rentals" do
      customer_two = customers(:curran)
      
      expect(customer_two.rentals.length).must_equal 0
    end
  end
  
  describe "validations" do
    before do 
      @customer = Customer.create(name: "Quinlan Rich", registered_at: "Fri, 10 Jul 2015 15:23:06 -0700", address: "Ap #727-9607 Nibh Avenue", city: "Hilo", state: "HI", postal_code: "63747", phone: "(521) 124-5753")
    end
    
    it "is valid when all fields are present" do
      
      expect(@customer.valid?).must_equal true
    end
    
    it "is not valid if name is not present" do 
      @customer.name = nil
      
      expect(@customer.valid?).must_equal false
    end
    
    it "is not valid if address is not present" do 
      @customer.address = nil
      
      expect(@customer.valid?).must_equal false
    end
    
    it "is not valid if city is not present" do 
      @customer.city = nil
      
      expect(@customer.valid?).must_equal false
    end
    
    it "is not valid if state is not present" do 
      @customer.state = nil
      
      expect(@customer.valid?).must_equal false
    end
    
    it "is not valid if postal code is not present" do 
      @customer.postal_code = nil
      
      expect(@customer.valid?).must_equal false
    end
    
    it "is not valid if phone is not present" do 
      @customer.phone = nil
      
      expect(@customer.valid?).must_equal false
    end
  end
end
