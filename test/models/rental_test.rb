require "test_helper"

describe Rental do
  describe "validations" do
    
    before do
      @valid_rental = Rental.first
    end
    
    it "checks that fixtures are sticking" do
      num = Rental.all.count
      expect(num).must_equal 4
    end
    
    it "rental is invalid if due date is missing" do
      @valid_rental.due_date = ""
      refute(@valid_rental.valid?)
    end
    
    it "rental is invalid if due date is not a type of date" do
      @valid_rental.due_date = "bananas"
      refute(@valid_rental.valid?)
    end
    
    it "rental is valid if due date is type of date" do
      valid_date = Date.today
      @valid_rental.due_date = valid_date
      assert(@valid_rental.valid?)
    end
    
    it "rental is invalid if checkout date is missing" do
      @valid_rental.checkout_date = ""
      refute(@valid_rental.valid?)
    end
    
    it "rental is invalid if checkout date is not a type of date" do
      @valid_rental.checkout_date = "bananas"
      refute(@valid_rental.valid?)
    end
    
    it "rental is valid if checkout date is type of date" do
      valid_date = Date.today
      @valid_rental.checkout_date = valid_date
      assert(@valid_rental.valid?)
    end
    
  end
  describe "relationship" do
    before do
      @valid_rental = Rental.first
    end
    
    it "rental is invalid if customer is not associated" do
      @valid_rental.customer_id = nil
      refute(@valid_rental.valid?)
    end
    
    it "rental is invalid if associated customer id is invalid" do
      @valid_rental.customer_id = -5
      refute(@valid_rental.valid?)
    end
    
    it "rental is invalid if movie is not associated" do
      @valid_rental.movie_id = nil
      refute(@valid_rental.valid?)
    end
    
    it "rental is invalid if associated movie id is invalid" do
      @valid_rental.movie_id = -1
      refute(@valid_rental.valid?)
    end
    
    it "valid customer and valid movie are associated with a rental" do
      
      rental = rentals(:r_1)
      
      movie = Movie.find_by(id: rental.movie_id)
      
      customer = Customer.find_by(id: rental.customer_id)
      
      expect(movie).wont_be_nil
      expect(customer).wont_be_nil
      
    end
    
  end
  
  #at some point, check that due date is in the future from checkout date
  
end
