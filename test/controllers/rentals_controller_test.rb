require "test_helper"

describe RentalsController do
  describe "checkout" do 

  end

  describe "checkin" do 
    it "finds the existing rental" do 
      rental = rentals(:one)
      post checkin_path(rental)
    end
  end
end
