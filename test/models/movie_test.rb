require "test_helper"

describe Movie do
  describe "validations" do
    before do 
      @movie = Movie.new(
        title: "fake movie",
        overview: "summary",
        release_date: Date.today,
        inventory: 1
      )
    end

    it "is avlid when all fields are present" do
      result = @movie.valid?

      expect(result).must_equal true
    end

    it "is invalid without a title" do
      @movie.title = nil
      result = @movie.valid?

      expect(result).must_equal false
    end

    it "is invalid with a duplicate title" do
      @movie.title = 'Titanic'
      result = @movie.valid?

      expect(result).must_equal false
    end 

    it "is invalid without a release_date" do
      @movie.release_date= nil
      result = @movie.valid?

      expect(result).must_equal false
    end

    it "is invalid without a inventory number" do
      @movie.inventory= nil
      result = @movie.valid?

      expect(result).must_equal false
    end

    it "is invalid without a invalid inventory number" do
      @movie.inventory= -1
      result = @movie.valid?
      
      expect(result).must_equal false
    end
  end
end
