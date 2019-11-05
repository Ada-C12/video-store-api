require "test_helper"

describe Customer do
  describe "relations" do
    it "has a list of rentals" do
      shelley = customers(:shelley)
      _(shelley).must_respond_to :rentals
      shelley.rentals.each do |rental|
        _(rental).must_be_kind_of Rental
      end
    end
  end
end
