require "test_helper"

describe Rental do
  before do 
    @rental = rentals(:one)
  end
  
  describe "validations" do 
    it "is valid when all fields are present" do 
      expect(@rental.valid?).must_equal true 
    end 
    
    it "is invalid without a movie" do 
      @rental.movie = nil 
      expect(@rental.valid?).must_equal false 
    end 
    
    it "is invalid without a customer" do 
      @rental.customer = nil 
      expect(@rental.valid?).must_equal false
    end 
  end 
  
  describe "relationships" do 
    it "belongs to a movie" do 
      expect(@rental.movie).must_be_kind_of Movie 
    end 
    
    it "belongs to a customer" do 
      expect(@rental.customer).must_be_kind_of Customer 
    end 
    
    it "can belong to more than one movie" do 
      rental_two = rentals(:two)
      rental_three = rentals(:three)
      result = rental_two.movie == rental_three.movie
      
      expect(result).must_equal true 
      expect(rental_two).must_be_kind_of Rental 
      expect(rental_three).must_be_kind_of Rental 
      
    end 
    
    it "can belong to more than one customer" do 
      rental_one = rentals(:one)
      rental_two= rentals(:two)
      result = rental_one.customer == rental_two.customer
      
      expect(result).must_equal true 
      expect(rental_one).must_be_kind_of Rental 
      expect(rental_two).must_be_kind_of Rental 
    end 
  end 
  
  describe "find_customer" do
    it "finds a customer by id" do
      @customer = custumers(:one)
      
    end   
  end
  
  describe "find_movie" do
    it "finds a movie by id" do 
    end 
  end
end
