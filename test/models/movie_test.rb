require "test_helper"

describe Movie do
  before do 
    @movie = movies(:m1)
  end
  
  describe "relations" do
    it "can have one or many rentals" do
      @movie.must_respond_to :rentals
      @movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end    
  end
end
