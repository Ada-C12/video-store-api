require "test_helper"

describe Rental do
  describe "relations" do
    let(:current_rental) { rentals(:rental1)}

    it "can get the movie from 'movie'" do
      expect(current_rental.movie).must_be_instance_of Movie
    end
    it "can get the customer from 'customer'" do
      expect(current_rental.customer).must_be_instance_of Customer
    end
  end
end
