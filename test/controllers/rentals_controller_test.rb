require "test_helper"

describe RentalsController do
  describe "checkin" do
    let(:customer) {
      customers(:eminique)
    }
    let(:movie) {
      movies(:titanic)
    }
    
    let(:rental_data) {
      {
          customer_id: customer.id,
          movie_id: movie.id,
        }
    }
    
    it "responds with JSON and success when passed in valid params and creates new rental" do
      expect(customer.movies_checked_out_count).must_equal 0
      expect(movie.available_inventory).must_equal 20
      
      expect {
        post checkout_path, params: rental_data
      }.must_differ 'Rental.count', 1

      body = JSON.parse(response.body)
      
      expect(body["id"]).must_be_instance_of Integer
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok

      binding.pry
      expect(customer.movies_checked_out_count).must_equal 1
      expect(movie.available_inventory).must_equal 19
    end
  end
end
