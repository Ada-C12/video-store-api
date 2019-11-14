require "test_helper"

describe Rental do
  
  describe "relationships" do
    
  end
  
  describe "validations" do 
    it "creates a rental if customer id, movie id, and due date are provided" do
      
      movie = movies(:harry)
      customer = customers(:three)
      
      expect{
        Rental.create(movie_id: movie.id, customer_id: customer.id, due_date: Date.today + 7)
      }.must_differ "Rental.count", 1
      
    end
    
    it "won't create a rental if customer id, movie id, and due date are missing" do
      
      invalid_rental = Rental.create
      
      _(invalid_rental.valid?).must_equal false
      _(invalid_rental.errors.messages).must_include :movie_id
      _(invalid_rental.errors.messages).must_include :customer_id
      _(invalid_rental.errors.messages).must_include :due_date
    end
  end
end
