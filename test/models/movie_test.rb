require "test_helper"

describe Movie do
  describe "relations" do
    let (:blacksmith) {movies(:blacksmith)}
    
    it "has a list of rentals" do
      _(blacksmith).must_respond_to :rentals
      blacksmith.rentals.each do |rental|
        _(rental).must_be_kind_of Rental
      end
    end
    
    it "can have no rentals" do
      _(movies(:curse).rentals.length).must_equal 0
    end
  end

  describe "validations" do
    it "requires YYYY-MM-DD format for release_date" do
      invalid_release_date_movie = Movie.create(release_date: "HAHAHAH")

      expect(invalid_release_date_movie.valid?).must_equal false
      expect(invalid_release_date_movie.errors).must_include "release_date"
    end
  end
end
