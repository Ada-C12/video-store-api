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
      start_checkout_count = valid_customer.movies_checked_out_count
      expect { post checkout_path, params: rental_data}.must_differ "Rental.count", 1
      new_rental = Rental.last
      expect _(new_rental.customer_id).must_equal rental_data[:customer_id]
      expect _(new_rental.movie_id).must_equal rental_data[:movie_id]
      expect _(new_rental.returned).must_equal false
      expect _(new_rental.checkout_date).must_equal Date.today
      expect _(new_rental.due_date).must_equal Date.today + 7

      updated_customer = Customer.find_by(id: valid_customer.id)
      expect _(updated_customer.movies_checked_out_count).must_equal start_checkout_count + 1
      
      check_response(expected_type: Hash, expected_status: :ok)
    end
    
    it "won't create a rental for invalid input and responds with bad request" do
      ["customer_id", "movie_id"].each do |key|
        data = rental_data.deep_dup
        
        data[key.to_sym] = nil
        expect { post checkout_path, params: data }.wont_change "Rental.count"
        
        body = check_response(expected_type: Hash, expected_status: :bad_request)
        expect(body.keys).must_include "errors"
        expect(body["errors"].keys).must_include key
      end
    end
    
  end

  describe "checkin" do
    before do
      post checkout_path, params: rental_data
      customer = Customer.find_by(id: valid_customer.id)
      @start_checkout_count = customer.movies_checked_out_count
    end

    it "can update with valid data" do
      rental = Rental.find_by(customer_id: valid_customer.id, movie_id: valid_movie.id)
      expect(rental.returned).must_equal false

      expect {
        post checkin_path, params: rental_data
      }.wont_change 'Rental.count'

      rental = Rental.find_by(customer_id: valid_customer.id, movie_id: valid_movie.id)
      expect(rental.returned).must_equal true

      updated_customer = Customer.find_by(id: valid_customer.id)
      expect _(updated_customer.movies_checked_out_count).must_equal @start_checkout_count - 1
    end 

    it "won't update with invalid data" do
      ["customer_id", "movie_id"].each do |key|
        data = rental_data.deep_dup
        
        data[key.to_sym] = -1
        expect { post checkin_path, params: data }.wont_change "Rental.count"
        
        body = check_response(expected_type: Hash, expected_status: :bad_request)
        expect(body.keys).must_include "errors"
        expect(body["errors"].keys).must_include key
      end
    end

    it "won't update if rental doesn't exist" do
      data = {
        movie_id: movies(:movie1).id,
        customer_id: valid_customer.id
      }

      expect { post checkin_path, params: data }.wont_change "Rental.count"
        
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body.keys).must_include "errors"
      expect(body["errors"].keys).must_include 'rental_id'
    end
  end
end