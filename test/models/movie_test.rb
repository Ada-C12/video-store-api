require "test_helper"

describe Movie do
  describe "relations" do
    it "has a list of rentals" do
      blacksmith = movies(:blacksmith)
      _(blacksmith).must_respond_to :rentals
      blacksmith.rentals.each do |rental|
        _(rental).must_be_kind_of Rental
      end
    end
  end
end
