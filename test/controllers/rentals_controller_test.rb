require "test_helper"

describe RentalsController do
  describe "checkout" do
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
      must_respond_with :ok
    end

    it "will not create a rental with missing attributes" do
      movie = movies(:movie1)
      rental_data = {
        rental: {
          movie_id: movie.id,
          customer_id: nil,
        }
      }

      expect {
        post rental_checkout_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body["errors"].keys).must_include "customer"
    end

    it "won't create a rental for a movie with 0 inventory" do
      movie = Movie.create(
        title: "title",
        overview: "Description", 
        release_date: Time.new(2018, 1, 1) ,
        inventory: 0,
      )
      customer = customers(:customer1)
      rental_data = {
        rental: {
          movie_id: movie.id,
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
      expect(body["errors"]).must_include "movie not available"
    end
  end

  describe "checkin" do
    it "will return the checked in rental's id and status of ok" do
      movie = movies(:movie1)
      customer = customers(:customer1)
      rental = Rental.create(movie: movie, customer: customer, checkout_date: Time.now, due_date: Time.now + 7)
      
      rental_data = {
        rental: {
          id: rental.id,
        }
      }
      
      post rental_checkin_path(rental.id), params: rental_data
      body = JSON.parse(response.body)
      expect(body.keys).must_include "id"
      must_respond_with :ok
    end


    # it will find a rental by it's id
    # it will increment the rental's movie's inventory by 1
    # it will decrement the rental's customer's movies_checked_out_count by 1



  end

end

