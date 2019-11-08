require "test_helper"

describe RentalsController do
  describe "checkout" do 
    let(:movie){movies(:m1)}
    let(:customer){customers(:c1)}

    it "checks out movie to customer by creating a Rental" do
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
      
      movie.reload 
      expect(movie.available_inventory).must_equal 9
    end 

    it "sends response for bad request" do 
      rental_hash = {
        customer_id: nil, 
        movie_id: movie.id
      }
        
      expect{ post checkout_path, params: rental_hash }.wont_change "Rental.count"
      must_respond_with :bad_request
        
      body = JSON.parse(response.body)
      expect(body['errors'].keys).must_include 'customer_id'
    end 

    it "should not allow rental if available inventory is 0" do 
      #INVENTORY DECREMENT IS NOT WORKING RIGHT NOW, COME BACK TO THIS
    end 

  end 
end
