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

      # rental = Rental.find_by(id: Rental.id)
      # expect(rental.check_out).must_equal 2019-11-07
      # expect(rental.due_date).must_equal 2019-11-14
    end 

    it "assigns the checkout date" do 
    end 
    
    it "assigns due date one week from checkout date" do 
    end 


  end 
end
