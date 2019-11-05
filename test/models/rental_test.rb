require "test_helper"

describe Rental do
  describe "relations" do
    let(:one) {rentals(:one)}
    
    it "belongs to a customer" do
      _(one).must_respond_to :customer
      _(one.customer).must_be_kind_of Customer
    end
    
    it "belongs to a movie" do
      _(one).must_respond_to :movie
      _(one.movie).must_be_kind_of Movie
    end
  end
  
end
