require "test_helper"

describe RentalsController do
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
  
  describe "checkout" do
    it "responds with JSON and success when passed in valid params and creates new rental and updates movies_checkout and available_inventory" do
      expect(customer.movies_checked_out_count).must_equal 0
      expect(movie.available_inventory).must_equal 20
      
      expect {
        post checkout_path, params: rental_data
      }.must_differ 'Rental.count', 1

      body = JSON.parse(response.body)
      
      expect(body["id"]).must_be_instance_of Integer
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok

      customer.reload
      movie.reload
      expect(customer.movies_checked_out_count).must_equal 1
      expect(movie.available_inventory).must_equal 19
    end
    
    it "responds with a bad request when missing a required field" do
      invalid_rental_data = {
        customer_id: nil,
        movie_id: movie.id,
      }

      expect {
        post checkout_path, params: invalid_rental_data
      }.must_differ 'Rental.count', 0

      must_respond_with :bad_request

      body = JSON.parse(response.body)

      expect(body["errors"]).must_equal "inventory unavailable"
    end

    it 'responds with bad request when movie doesnt have available inventory' do 
      unavailable_movie = movies(:chappie)
      invalid_rental_data = {
        customer_id: customer.id,
        movie_id: unavailable_movie.id,
      }

      expect {
        post checkout_path, params: invalid_rental_data
      }.must_differ 'Rental.count', 0

      must_respond_with :bad_request

      body = JSON.parse(response.body)

      expect(body["errors"]).must_equal "inventory unavailable"
    end
  
  end

  describe "checkin" do
    it "responds with JSON and success when passed in valid params and updates movies_checkout and available_inventory" do
      post checkout_path, params: rental_data
      
      expect {
        post checkin_path, params: rental_data
      }.must_differ 'Rental.count', 0

      body = JSON.parse(response.body)
      
      expect(body["available_inventory"]).must_be_instance_of Integer
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok

      customer.reload
      movie.reload
      expect(customer.movies_checked_out_count).must_equal 0
      expect(movie.available_inventory).must_equal 20
    end
    
    it "responds with a bad request when missing a required field" do
      invalid_rental_data = {
        customer_id: nil,
        movie_id: movie.id,
      }

      expect {
        post checkin_path, params: invalid_rental_data
      }.must_differ 'Rental.count', 0

      must_respond_with :bad_request

      body = JSON.parse(response.body)

      expect(body["errors"]).must_equal "inventory unavailable"
    end
  end


end
