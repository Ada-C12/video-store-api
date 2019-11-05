require "test_helper"

describe Movie do
  describe "instantiation" do
    it "can instantiate a valid product" do
      new_movie = Movie.new(
        title: "Titanic",
        overview: "The door wasn't big enough for two.",
        release_date: Time.now,
        inventory: 10,
      )
      expect(new_movie.save).must_equal true
    end

  end
  
  describe "relationships" do
    it "can have many rentals" do
      # rental_1 = Rental.new
      # rental_2 = Rental.new
      # rental_3 = Rental.new

    end
  end

  describe "validations" do
    it "must have a title" do
    end

    it "inventory can't be nil" do
    end
  end


end
