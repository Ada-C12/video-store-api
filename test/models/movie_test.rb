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
end
