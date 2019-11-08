require "test_helper"

describe RentalsController do

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'
    
    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end 


  let(:customer) {
    customers(:three)
  }

  let(:movie) {
    movies(:one)
  }
  
  let(:rental_data) {
    {
      customer_id: customer.id,
      movie_id: movie.id,
      }
  }
  
  describe "checkout" do
    it "responds with success when passed in valid params" do
      post checkout_path, params: rental_data

      body = check_response(expected_type: Hash, expected_status: :success)

      # new_rental = Rental.find(body["id"])
      expect(body.keys).must_include "id"
    end

    it "creates a new rental" do
      expect {
        post checkout_path, params: rental_data
      }.must_differ 'Rental.count', 1 
        
    end

    it "updates customer movies_checked_out" do 
      post checkout_path, params: rental_data
      body = check_response(expected_type: Hash, expected_status: :success)

      new_rental = Rental.find(body["id"])
      customer = new_rental.customer
      expect(customer.movies_checked_out_count).must_equal 1
    end 

    it "updates movie available_inventory" do 
      post checkout_path, params: rental_data
      body = check_response(expected_type: Hash, expected_status: :success)

      new_rental = Rental.find(body["id"])
      movie = new_rental.movie
      expect(movie.available_inventory).must_equal 9
    end 

    it "responds with bad request when passed invalid params" do 
      invalid_rental_data = {
        customer_id: nil,
        movie_id: movie.id
      }

      expect{post checkout_path, params: invalid_rental_data}.wont_change 'Rental.count'

      body = check_response(expected_type: Hash, expected_status: :bad_request)

      expect(body["errors"]).must_equal "none available"
    end 
  end 

  describe "checkin" do 
  end 

end
