require "test_helper"

describe Movie do
  describe "validation" do
    it "will create movie if title is present" do
      movie = Movie.new(title: "valid movie")
      
      is_valid = movie.valid?
      
      assert(is_valid)
    end
    
    it "will not create movie if title is not present" do
      movie = Movie.new()
      
      is_valid = movie.valid?
      
      refute(is_valid)
    end
  end
  
  describe "relationships" do
    it "can have many rentals" do
      movie = Movie.create(title: "valid movie")
      customer = Customer.create(name: "valid customer")
      rental = Rental.create(movie_id: movie.id, customer_id: customer.id)
      
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
      expect(movie.rentals.length).must_equal 1
    end
  end
  
end
