require "test_helper"

describe Movie do
  describe "instantiation" do
    it "can be instantiated" do
      
      new_movie = Movie.new(
        title: "John Wick 3",
        overview: "Wick must fight his way through the streets of New York as he becomes the target of the world's most ruthless killers.",
        release_date: "2019-05-17",
        inventory: 4,
      )
      
      new_movie.save!
      expect(new_movie.valid?).must_equal true
    end
    
    it "will have the required fields" do
      movie = Movie.first
      expect(movie).must_respond_to :title
      expect(movie).must_respond_to :overview
      expect(movie).must_respond_to :release_date
      expect(movie).must_respond_to :inventory
      expect(movie).must_respond_to :available_inventory
    end
  end
  
  describe "relationships" do
    it "can have many rentals" do
      movie= Movie.first
      
      expect(movie.rentals.count).must_be :>=, 0
      movie.rentals.each do |rental|
        expect(rental).must_be_instance_of Rental
      end
    end
  end
  
  describe "validations" do
    before do
      @movie = Movie.first
    end
    
    it "must have a title" do
      @movie.title = nil
      expect(@movie.valid?).must_equal false
      expect(@movie.errors.messages).must_include :title
      expect(@movie.errors.messages[:title]).must_equal ["can't be blank"]
    end
    
    it "title must be unique" do
      @movie2 = Movie.create(title: @movie.title)
      expect(@movie2.valid?).must_equal false
      expect(@movie2.errors.messages).must_include :title
      expect(@movie2.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end
end
