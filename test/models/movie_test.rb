require "test_helper"

describe Movie do
  let(:movie) {
    movies(:croods)
  }

  describe "validations" do
    it "can be created" do
      assert(movie.valid?)
    end

    it "requires title, overview, release_date, inventory" do
      required_fields = [:title, :overview, :release_date, :inventory]

      required_fields.each do |field|
        movie[field] = nil
        refute(movie.valid?)
        movie.reload
      end
    end
  end

  describe "relationships" do
    it "has a list of rentals" do
      _(movie).must_respond_to :rentals
      movie.rentals.each do |rental|
        _(rental).must_be_instance_of Rental
      end
    end
  end

  describe "custom methods" do
    describe "set_inventory" do
      it "will set the available inventory to the movie's inventory" do
        movie.set_inventory

        expect(movie.available_inventory).must_equal movie.inventory
      end
    end

    describe "check_inventory" do
      it "will return true when available inventory is greater than 0" do
        movie.set_inventory
        assert(movie.check_inventory)
      end

      it "will return false when available inventory is less than or equal to 0" do
        movie.set_inventory
        10.times { movie.decrease_inventory }
        refute(movie.check_inventory)
      end
    end

    describe "decrease_inventory" do
      it "will decrease the movie's inventory" do
        movie.set_inventory

        movie.decrease_inventory

        expect(movie.available_inventory).must_equal 9
      end
    end

    describe "increase_inventory" do
      it "will increase the movie's inventory" do
        movie.set_inventory

        movie.increase_inventory

        expect(movie.available_inventory).must_equal 11
      end
    end
  end
end
