require "test_helper"

describe RentalsController do
  describe "checkout" do 
    it "checks out movie to customer by creating a Rental" do 
      movie = movies(:m1)
      customer = customers(:c1)

      rental_hash = {
          customer_id: customer.id, 
          movie_id: movie.id
      }
    
      expect{ post checkout_path, params: rental_hash }.must_differ "Rental.count", 1

      body = JSON.parse(response.body)
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :created

      rental = Rental.find_by(movie_id: movie.id)
      
      expect(rental.check_out).must_be_kind_of Time
      expect(rental.due_date).must_be_kind_of Time
      binding.pry
      expect(rental.movie.available_inventory).must_equal 9
    end 

    it "sends response for bad request" do 
    end 

    it "should not allow rental if available inventory is 0" do 
    end 

  end 
end
