require "test_helper"

describe Movie do
  let(:curse){movies(:curse_no_rentals)}
  let(:shelley){customers(:shelley)}

  describe "relations" do
    let (:blacksmith) {movies(:blacksmith)}
    
    it "has a list of rentals" do
      _(blacksmith).must_respond_to :rentals
      blacksmith.rentals.each do |rental|
        _(rental).must_be_kind_of Rental
      end
    end
    
    it "can have no rentals" do
      _(curse.rentals.length).must_equal 0
    end
  end

  describe "validations" do
    it "requires YYYY-MM-DD format for release_date" do
      invalid_release_date_movie = Movie.create(release_date: "HAHAHAH")

      expect(invalid_release_date_movie.valid?).must_equal false
      expect(invalid_release_date_movie.errors).must_include "release_date"
    end
  end

  describe "custom methods" do
    describe "available_inventory" do
      it "returns the same value as inventory if it has no rentals" do
        # act/assert
        expect(curse.rentals.count).must_equal 0
        expect(curse.available_inventory).must_equal curse.inventory
      end

      it "returns a decreased value when a movie is checked out" do
        start_availability_count = curse.available_inventory
        expect(curse.rentals.count).must_equal 0

        new_rental = Rental.create(movie_id: curse.id, customer_id: shelley.id, checkout_date: DateTime.now, due_date: DateTime.now + 7 )

        curse.rentals << new_rental

        expect(curse.rentals.count).must_equal 1
        expect(curse.available_inventory).must_equal 0
      end
    end
  end
end
