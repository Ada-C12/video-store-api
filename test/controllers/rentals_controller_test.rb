require "test_helper"

describe RentalsController do
  describe "checkout" do 
    it "creates a new instance of Rental if the movie is available" do 
      movie = movies(:movie1)
      customer = customers(:customer1)

      new_rental = {
        customer_id: customer.id, 
        movie_id: movie.id
      }
      expect{
      post check_out_path(new_rental)
      }.must_differ "Rental.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
    end
    
    # it "returns an error and doesn't make in instance of Rental if movie is not available" do 
    #   movie = movies(:movie3)
    #   customer = customers(:customer1)

    #   new_rental = {
    #     customer_id: customer.id, 
    #     movie_id: movie.id
    #   }
    #   expect{
    #   post check_out_path(new_rental)
    #   }.wont_change "Rental.count"
    #   body = JSON.parse(response.body)

    #   must_respond_with :bad_request
    #   expect(response.header["Content-Type"]).must_include "json"
    #   expect(body).must_be_instance_of Hash
    #   expect(body.keys).must_include "errors"
    # end 
  end
end
