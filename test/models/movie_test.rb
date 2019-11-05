require "test_helper"

describe Movie do
  describe "validation" do
    it "will create movie if title is present" do
      movie = Movie.new(title: "valid movie")

      is_valid = movie.valid?

      assert(is_valid)
    end

    it "will not create movie if title is not present" do
      movie = Movie.new()

      is_valid = movie.valid?

      refute(is_valid)
    end
  end
end
