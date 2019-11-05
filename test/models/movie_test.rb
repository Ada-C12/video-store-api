require "test_helper"

describe Movie do
  describe "validations" do
    it "can be created" do
      movie = movies(:movie_one)
      expect(movie.valid?).must_equal true
    end
  end
end
