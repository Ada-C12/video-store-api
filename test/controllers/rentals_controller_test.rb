require "test_helper"

describe RentalsController do
  describe "checkout" do
    it "can checkout a movie by creating a new rental with valid input and available inventory" do
      movie = Movie.create(title: "valid movie", inventory: 10, available_inventory: 10)
      customer = Customer.create(name: "valid customer")
      expect{ post checkout_path }.must_change "Rental.count", 1
      
      must_respond_with :ok
    end

    it "will not create rental without available inventory" do
      movie = Movie.create(title: "valid movie", inventory: 10, available_inventory: 0)
      customer = Customer.create(name: "valid customer")

      expect{ post checkout_path }.wont_change "Rental.count"
      
      must_respond_with :bad_request
    end
  end
end
