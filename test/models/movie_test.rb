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
end
