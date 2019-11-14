require "test_helper"

describe Rental do
  describe "relationships" do 
    before do 
      @user = Customer.new(name: "CloMar", address: "801 Dexter Ave", registered_at: Date.parse("Wed, 29 Apr 2015"), city: "Seattle", state: "WA", postal_code: "98116")
      @movie = Movie.new(title: "Up", overview: "hot air balloons", release_date: "November 6, 2019", inventory: 5)
      @rental = Rental.new(customer_id: @user.id, movie_id: @movie.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
    end
    
    it "belongs to a customer" do 
      expect(@rental.customer_id).must_equal @user.id 
    end
    
    it "has a movie" do 
      expect(@rental.movie_id).must_equal @movie.id
    end
  end
  
  describe "validations" do 
    before do 
      # Arrange
      @user = Customer.new(name: "CloMar", address: "801 Dexter Ave", registered_at: Date.parse("Wed, 29 Apr 2015"), city: "Seattle", state: "WA", postal_code: "98116")
      @movie = Movie.new(title: "Up", overview: "hot air balloons", release_date: "November 6, 2019", inventory: 5)
      @rental = Rental.new(customer_id: @user.id, movie_id: @movie.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
    end
    
    it "has a customer id" do
      expect(@rental.customer_id).must_equal @user.id
    end
    
    it "is invald without a customer id" do
      rental = Rental.new(customer_id: nil, movie_id: @movie.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
      
      expect(rental.valid?).must_equal false
    end
    
    it "has a movie id" do
      expect(@rental.movie_id).must_equal @movie.id
    end
    
    it "will be invalid without a movie" do
      rental = Rental.new(customer_id: @user.id, movie_id: nil, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
      
      expect(rental.valid?).must_equal false
    end
    
    it "will have a checkout date" do
      expect(@rental.check_out_date).wont_be_nil
    end
    
    it "will be invalid if checkout date is not present" do
      rental = Rental.new(customer_id: @user.id, movie_id: @movie.id, check_out_date: nil, due_date: Date.today + 7, check_in_date: nil)
      
      expect(rental.valid?).must_equal false
    end
    
    it "will have a due date" do
      expect(@rental.due_date).wont_be_nil
    end
    
    it "will be invalid without a due date" do
      rental = Rental.new(customer_id: @user.id, movie_id: @movie.id, check_out_date: Date.today, due_date: nil, check_in_date: nil)
      
      expect(rental.valid?).must_equal false
      
    end
  end
end
