require "test_helper"

describe Movie do
  before do
    @movie = movies(:one)
  end
  
  describe "validations" do  
    it "is valid when all fields are present" do
      result = @movie.valid?
      expect(result).must_equal true
    end
    
    it "is invalid without a title" do
      @movie.title = nil
      result = @movie.valid?
      expect(result).must_equal false
    end
    
    it "is invalid without a overview" do
      @movie.overview = nil
      result = @movie.valid?
      expect(result).must_equal false
    end
    
    it "is invalid without a release date" do
      @movie.release_date = nil
      result = @movie.valid?
      expect(result).must_equal false
    end
    
    it "is invalid without a inventory" do
      @movie.inventory = nil
      result = @movie.valid?
      expect(result).must_equal false
    end
  end
  
  describe "relationships" do   
    it "can have many rentals" do
      expect(@movie.rentals.count).must_equal 2
    end
    
    it "can have many customers" do
      expect(@movie.customers.count).must_equal 2
    end 
  end 
end
