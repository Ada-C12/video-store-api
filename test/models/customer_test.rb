require "test_helper"

describe Customer do
  describe "relationships" do 
    it "has movies" do 
      # Arrange
      mariya = customers(:mariya)
      up = movies(:up)
      avengers = movies(:avengers)
      zootopia = movies(:zootopia)
      
      #Act
      rental = Rental.create(customer_id: mariya.id, movie_id: up.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
      rental = Rental.create(customer_id: mariya.id, movie_id: avengers.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
      rental = Rental.create(customer_id: mariya.id, movie_id: zootopia.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
      
      # Assert
      expect(mariya.movies.count).must_equal 3
      
    end
    
    it "has rentals [customer]" do 
      # Arrange
      mariya = customers(:mariya)
      up = movies(:up)
      
      # Act
      rental = Rental.create(customer_id: mariya.id, movie_id: up.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
      
      # Assert
      expect(mariya.movies.count).must_equal 1
    end
  end
  
  describe "validations" do 
    before do 
      @mariya = customers(:mariya)
    end 
    
    it "has a name" do 
      # Assert
      @mariya.name.must_equal "mariya"
    end
    
    it "will fail if it doesnt have a name" do
      bad_user = Customer.new(name: nil, address: "801 Dexter Ave", registered_at: Date.parse("Wed, 29 Apr 2015"), city: "Seattle", state: "WA", postal_code: "98116")
      
      expect(bad_user.valid?).must_equal false
    end
    
    it "has registered_at" do 
      # Assert
      @mariya.registered_at.wont_be_nil
    end
    
    it "will fail if it isnt registered" do
      bad_user = Customer.new(name: "Cloudy", address: "801 Dexter Ave", registered_at: nil, city: "Seattle", state: "WA", postal_code: "98116")
      
      expect(bad_user.valid?).must_equal false
    end
    
    it "has an address" do 
      @mariya.address.wont_be_nil
    end
    
    it "will fail if an address is not provided" do 
      bad_user = Customer.new(name: "Cloudy", address: nil, registered_at: Date.parse("Wed, 29 Apr 2015"), city: "Seattle", state: "WA", postal_code: "98116")
      
      expect(bad_user.valid?).must_equal false
    end
    
    it "has a city" do 
      @mariya.city.wont_be_nil
    end
    
    it "will fail if a city is not provided" do 
      bad_user = Customer.new(name: "Cloudy", address: "801 Dexter Ave", registered_at: Date.parse("Wed, 29 Apr 2015"), city: nil, state: "WA", postal_code: "98116")
      
      expect(bad_user.valid?).must_equal false
    end
    
    it "has a state" do 
      @mariya.state.wont_be_nil
    end
    
    it "will fail if a state is not provided" do
      bad_user = Customer.new(name: "Cloudy", address: "801 Dexter Ave", registered_at: Date.parse("Wed, 29 Apr 2015"), city: "Seattle", state: nil, postal_code: "98116")
      
      expect(bad_user.valid?).must_equal false
    end
    
    it "has a postal code" do 
      @mariya.postal_code.wont_be_nil
    end
    
    it "will fail if a zipcode is not provided" do
      bad_user = Customer.new(name: "Cloudy", address: "801 Dexter Ave", registered_at: Date.parse("Wed, 29 Apr 2015"), city: "Seattle", state: "WA", postal_code: nil)
      
      expect(bad_user.valid?).must_equal false
    end
    
    it "has a phone number" do 
      @mariya.phone.wont_be_nil
    end
    
    it "will fail if a phone number is not listed" do
      bad_user = Customer.new(name: "Cloudy", address: "801 Dexter Ave", registered_at: Date.parse("Wed, 29 Apr 2015"), city: nil, state: "WA", postal_code: "98116")
      
      expect(bad_user.valid?).must_equal false
    end
  end
end
