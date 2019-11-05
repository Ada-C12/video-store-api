require "test_helper"

describe Customer do
  
  describe "relationships" do
    it "can have many rentals" do
      movie = Movie.create(title: "valid movie")
      customer = Customer.create(name: "valid customer")
      rental = Rental.create(movie_id: movie.id, customer_id: customer.id)
      
      customer.must_respond_to :rentals
      customer.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
      expect(customer.rentals.length).must_equal 1
    end
  end
  
end
