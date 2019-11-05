require "test_helper"

describe RentalsController do
  describe "checkout" do
    before do
      movie = Movie.create(title: "valid movie", inventory: 10, available_inventory: 10)
      customer = Customer.create(name: "valid customer")
    end
    
    it "can checkout a movie by creating a new rental" do
      expect{ post checkout_path }.must_change "Rental.count", 1
      
      must_respond_with :ok
      
    end
  end
end
