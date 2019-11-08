require "test_helper"


describe RentalsController do
  let(:movie){movies(:m1)}
  let(:customer){customers(:c1)}
  
  describe "checkout" do 
    
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
      rental_hash = {
        customer_id: customer.id, 
        movie_id: movies(:m2).id
      }
      
      expect{ post checkout_path, params: rental_hash }.wont_change "Rental.count"
      must_respond_with :bad_request
      
      body = JSON.parse(response.body)
      expect(body['errors']).must_equal "available inventory is 0"
    end 
    
  end 
  
  describe "checkin" do 
    
    it "checks in a returning movie" do
      rental_hash = {
        customer_id: customer.id, 
        movie_id: movie.id
      }
      
      post checkout_path, params: rental_hash

      updates = { rental: { checkin: Time.now } }
      expect {patch checkin_path(rentals(:r1).id), params: updates}.wont_change "Rental.count"  
      must_respond_with :ok
      
      body = JSON.parse(response.body)
      expect(response.header['Content-Type']).must_include 'json'
      expect(rentals(:r1).check_in).must_be_kind_of Time
      
      movie.reload 
      expect(movie.available_inventory).must_equal 10
    end 

    it "returns not_found if rental is not found" do 
      updates = { rental: { checkin: Time.now } }
      expect {patch checkin_path(-100), params: updates}.wont_change "Rental.count"  
      must_respond_with :not_found
    end
    
      # it "sends response for bad request" do 
    
      #   expect{ post checkout_path, params: rental_hash }.wont_change "Rental.count"
      #   must_respond_with :bad_request
    
      #   body = JSON.parse(response.body)
      #   expect(body['errors'].keys).must_include 'customer_id'
      # end     
   
  end
end
