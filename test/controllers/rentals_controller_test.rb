require "test_helper"

describe RentalsController do
  let(:valid_customer) { customers(:customer3) }
  let(:valid_movie) { movies(:movie3) }
  let(:rental_data) {
    {
      movie_id: valid_movie.id,
      customer_id: valid_customer.id
    }
  }
  
  describe "checkout" do
    it "can create a rental for valid input and responds with ok" do
      expect { post checkout_path, params: rental_data}.must_differ "Rental.count", 1
      new_rental = Rental.last
      expect _(new_rental.customer_id).must_equal rental_data[:customer_id]
      expect _(new_rental.movie_id).must_equal rental_data[:movie_id]
      expect _(new_rental.returned).must_equal false
      expect _(new_rental.checkout_date).must_equal Date.today
      expect _(new_rental.due_date).must_equal Date.today + 7
      
      body = JSON.parse(response.body)
      
      expect _(body).must_be_instance_of Hash
      expect _(body.keys).must_include "id"
      must_respond_with :ok
    end
    
    it "won't create a rental for invalid input and responds with bad request" do
      ["customer_id", "movie_id"].each do |key|
        data = rental_data.deep_dup
        
        data[key.to_sym] = nil
        expect { post checkout_path, params: data }.wont_change "Rental.count"
        
        must_respond_with :bad_request
        
        body = JSON.parse(response.body)
        expect(body.keys).must_include "errors"
        expect(body["errors"].keys).must_include key
      end
    end
    
  end
end
