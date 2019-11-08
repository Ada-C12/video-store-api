require "test_helper"

describe Movie do
  before do 
    @movie = Movie.new(
      title: "fake movie",
      overview: "summary",
      release_date: Date.today,
      inventory: 1
    )
  end
  
  describe "initialize" do
    it "can create a new movie with available inventory equal to inventory" do
      params = { 
        title: "fake movie",
        overview: "summary",
        release_date: Date.today,
        inventory: 1
      }
      
      new_movie = Movie.new(params)
      
      expect _(new_movie.available_inventory).must_equal params[:inventory]
    end
  end
  
  describe "validations" do
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
      @movie.release_date = nil
      result = @movie.valid?
      
      expect(result).must_equal false
    end
    
    it "is invalid without a inventory number" do
      @movie.inventory = nil
      result = @movie.valid?
      
      expect(result).must_equal false
    end
    
    it "is invalid without a invalid inventory number" do
      @movie.inventory = -1
      result = @movie.valid?
      
      expect(result).must_equal false
    end
  end
  
  describe "relationship" do
    before do 
      @rental = Rental.new(
        checkout_date: Date.today,
        due_date: Date.today + 7,
        movie_id: movies(:movie1).id,
        customer_id: customers(:customer3).id
      )
    end
    
    it "can have many movies through rental" do
      @rental.save
      
      movie = Movie.find_by(id: movies(:movie1).id)
      
      expect(movie.customers.count).must_be :>=, 0
      expect(movie.customers).must_include customers(:customer3)
    end 
  end
end