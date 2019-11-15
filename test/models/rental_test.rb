require "test_helper"

describe Rental do
  let (:rental1) {rentals(:rental1) }
  describe "relationships" do

    it "belongs to movie" do
      expect(rental1.movie).must_be_instance_of Movie
      expect(rental1.movie).wont_be_nil
    end

    it "belongs to customer" do
      expect(rental1.customer).must_be_instance_of Customer
      expect(rental1.customer).wont_be_nil
    end
  end
end
