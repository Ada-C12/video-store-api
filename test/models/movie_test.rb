require "test_helper"

describe Movie do
  describe "validations" do
    before do
      @movie = Movie.create(title: "Movie1", overview: "Amazing", release_date: Date.today, inventory: 111)
    end
    
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
end 
