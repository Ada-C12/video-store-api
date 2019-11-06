require "test_helper"

describe Rental do
  before do 
    @rental = rentals(:r1)
  end
  
  describe "relations" do
    it "belongs to one customer" do
      _(@rental).must_respond_to :customer
      _(@rental.customer).must_be_instance_of Customer
    end    

    it "belongs to one movie" do
      _(@rental).must_respond_to :movie
      _(@rental.movie).must_be_instance_of Movie
    end    
  end
end
