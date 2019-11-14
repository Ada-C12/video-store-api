require "test_helper"

describe RentalsController do
  describe "check_out" do
    it "creates a new instance of Rental if the movie is available" do
      movie = movies(:movie1)
      customer = customers(:customer1)

      new_rental = {
        customer_id: customer.id,
        movie_id: movie.id,
      }
      expect {
        post check_out_path(new_rental)
      }.must_differ "Rental.count", 1

      expect(new_rental[:customer_id]).must_equal customer.id
      expect(new_rental[:movie_id]).must_equal movie.id
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
    end


    it "returns an error of Bad Request given bad rental data" do
      new_rental = nil

      expect { 
        post check_out_path(new_rental)
      }.wont_change "Rental.count"

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      expect(body['errors']).must_include "Bad Request"
    end
  end

  describe "check_in" do
    it "changes the status of the given rental to checked in" do
      customer = customers(:customer1)
      movie = movies(:movie1)

      rental = {
        customer_id: customer.id,
        movie_id: movie.id,
      }

      post check_in_path(rental)

      test_rental = rentals(:rental1)

      expect(test_rental.status).must_equal "checked_in"
    end

    
    #tests negative case in validations
  end
  


end
