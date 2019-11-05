require "test_helper"

describe Movie do
  let(:movie) {movies(:blacksmith)}
  let(:customer) { customers(:shelley) }
  let(:customer2) { customers(:curran) }
  
  describe "relations" do
    it "can have many rentals" do
      Rental.create(movie_id: movie.id, customer_id: customer.id)
      Rental.create(movie_id: movie.id, customer_id: customer2.id)
      
      expect(movie.rentals.length).must_equal 2
    end
    
    it "can have zero rentals" do
      expect(movie.rentals.length).must_equal 0
    end
  end
  
  describe "validations" do
    before do
      @movie = Movie.create(title: "Wizard of Oz", overview: "There's no place like home.", release_date: "1939-08-25", inventory: 5)
    end
    
    it "is valid when all fields are present" do
      expect(@movie.valid?).must_equal true
    end
    
    it "is not valid when title is missing" do
      @movie.title = nil
      
      expect(@movie.valid?).must_equal false
    end
    
    it "is not valid when overview is missing" do
      @movie.overview = nil
      
      expect(@movie.valid?).must_equal false
    end
    
    it "is not valid when release_date is missing" do
      @movie.release_date = nil
      
      expect(@movie.valid?).must_equal false
    end
    
    it "is not valid when inventory is missing" do
      @movie.inventory = nil
      
      expect(@movie.valid?).must_equal false
    end
    
    it "is not valid when inventory is not an integer" do
      @movie.inventory = "five"
      
      expect(@movie.valid?).must_equal false
    end
  end 
end
