require "test_helper"

describe Movie do
  describe "validations" do
    
    before do
      @valid_movie = Movie.first
    end
    
    it "checks to see if fixtures are sticking" do
      num = Movie.all.count
      expect(num).must_equal 5
    end
    
    it "movies are invalid if title is missing" do
      @valid_movie.title = ""
      refute(@valid_movie.valid?)
    end
    
    it "movies are invalid if overview is missing" do
      @valid_movie.overview = ""
      refute(@valid_movie.valid?)
    end
    
    it "movies are invalid if release_date is missing" do
      @valid_movie.release_date = ""
      refute(@valid_movie.valid?)
    end
    
    it "movies are invalid if release_date is not a type of date" do 
      @valid_movie.release_date = "bananas"
      refute(@valid_movie.valid?)
    end
    
    it "movies are invalid if release_date is not a type of date" do 
      valid_date = Date.today
      @valid_movie.release_date = valid_date
      assert(@valid_movie.valid?)
    end
    
    it "movies are invalid if inventory is missing" do
      @valid_movie.inventory = nil
      refute(@valid_movie.valid?)
    end
    
    it "movies are invalid if inventory is not an integer" do
      @valid_movie.inventory = "bananas"
      refute(@valid_movie.valid?)
    end
    
    it "movies are invalid if inventory is a negative integer" do
      @valid_movie.inventory = -2
      refute(@valid_movie.valid?)
    end
    
    it "movies are valid if inventory is a positive integer" do
      @valid_movie.inventory = 1
      # binding.pry
      assert(@valid_movie.valid?)
    end
    
    it "movies are valid if inventory is zero" do
      @valid_movie.inventory = 0
      assert(@valid_movie.valid?)
    end
    
    # it "movies are invalid if available_inventory is missing" do
    #   @valid_movie.available_inventory = nil
    #   refute(@valid_movie.valid?)
    # end
    
    # it "movies are invalid if available_inventory is not an integer" do
    #   @valid_movie.available_inventory = "bananas"
    #   refute(@valid_movie.valid?)
    # end
    
    # it "movies are invalid if available_inventory is a negative integer" do
    #   @valid_movie.available_inventory = -2
    #   refute(@valid_movie.valid?)
    # end
    
    # it "movies are valid if available_inventory is a positive integer" do
    #   @valid_movie.available_inventory = 1
    #   assert(@valid_movie.valid?)
    # end
    
    # it "movies are valid if available_inventory is zero" do
    #   @valid_movie.available_inventory = 0
    #   assert(@valid_movie.valid?)
    # end
  end
  
  describe "relationships" do
    it "movie rentals are verifiable" do
      expected_rental = 1
      movie = movies(:m_2)
      expect(movie.rentals.count).must_equal expected_rental
    end
    
    it "movie without rentals does not have rentals" do
      expected_rental = 0
      movie = movies(:m_5)
      expect(movie.rentals.count).must_equal expected_rental
    end
  end
  
end
