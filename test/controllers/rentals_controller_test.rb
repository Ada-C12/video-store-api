require "test_helper"

describe RentalsController do
  describe "checkout" do
    # when POST /rentals/check-out controller action is hit
    # create a new instance of a rental
    # checkout_date is set to Time.now
    # due_date is set to 7 days from checkout_date

    # movie_id is passed in the request body
    # customer_id passed in the request body

    # once the rental is created, reduce the inventory of that movie 
    # by one. -- maybe a model method?

    it "will create a new instance of a rental and return an id" do
      movie = movies(:movie1)
      customer = customers(:customer1)
      rental_data = {
        rental: {
          movie_id: movie.id,
          customer_id: customer.id,
        }
      }

      expect {
        post rental_checkout_path, params: rental_data
      }.must_differ "Rental.count", 1
      
      body = JSON.parse(response.body)
      expect(body.keys).must_include "id"
      must_respond_with :created
    end

    it "will not create a rental with missing attributes" do
      customer = customers(:customer1)
      rental_data = {
        rental: {
          movie_id: nil,
          customer_id: customer.id,
        }
      }

      expect {
        post rental_checkout_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body["errors"].keys).must_include "movie"
    end
  end
end
