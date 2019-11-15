require "test_helper"

describe Movie do

  let (:movie) {movies(:titanic)}

  describe "instantiations" do

    it "can be instantiated" do

      expect(movie.valid?).must_equal true
    end 
  end 

  describe "relations" do
    it "can access the rentals for each movie" do
    


      expect(movie.rentals.count).must_equal 1
    end 

    it "will return 0 rentals if no rentals exists for that movie" do
      movie = movies(:batman)

      expect(movie.rentals.count).must_equal 0
      expect(movie.rentals).must_equal []
    end 
  end

  describe "validations" do
    # let (:new_movie) {Movie.create!(title: "notebook", overview: "romantic story", release_date: "2002-10-09", inventory: 20, available_inventory: 20)}

    it "must have a title" do


      movie.title = nil

      # fixture data does not run validations, so use the let value
      
      #Assert
      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :title
      # binding.pry
      expect(movie.errors.messages[:title]).must_equal ["can't be blank"]
    end 

    it "must have an overview" do


      movie.overview = nil

      # fixture data does not run validations, so use the let value
      
      #Assert
      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :overview
      expect(movie.errors.messages[:overview]).must_equal ["can't be blank"]
    end 

    it "must have a release date" do


      movie.release_date = nil

      # fixture data does not run validations, so use the let value
      
      #Assert
      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :release_date
      expect(movie.errors.messages[:release_date]).must_equal ["can't be blank"]
    end 

    it "must have an inventory" do


      movie.inventory = nil

      # fixture data does not run validations, so use the let value
      
      #Assert
      expect(movie.valid?).must_equal false
      expect(movie.errors.messages).must_include :inventory
      expect(movie.errors.messages[:inventory]).must_equal ["can't be blank"]
    end 
  end 
end
