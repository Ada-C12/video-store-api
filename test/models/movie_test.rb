require "test_helper"

describe Movie do
  describe "relations" do
    let(:current_movie) { movies(:movie1)}

    it "can get the list of rentals from 'rentals'" do
      expect(current_movie.rentals.length).must_equal 2
      expect(current_movie.rentals[0]).must_be_instance_of Rental
      expect(current_movie.rentals[0].movie).must_equal movies(:movie1)
    end
  end

  describe "validations" do 

    it "is invalid without a title" do 
      movie = movies(:movie1)
      movie.title = nil

      result = movie.valid?

      expect(result).must_equal false
    end

    it "is valid with a title" do 
      movie = movies(:movie1)

      result = movie.valid?

      expect(result).must_equal true
    end

    it "is invalid with an inventory of less than zero" do
      movie = movies(:movie1)
      movie.inventory = -1

      result = movie.valid?

      expect(result).must_equal false
    end

    it "is invalid with an nonnumeric inventory" do 
      movie = movies(:movie1)
      movie.inventory = nil

      result = movie.valid?

      expect(result).must_equal false
    end 

    it "is valid with a valid inventory" do 
      movie = movies(:movie1)
      movie.inventory = 5

      result = movie.valid?

      expect(result).must_equal true
    end
  end

  

end
