require "test_helper"

describe RentalsController do
  describe "checkout" do
    it "creates a new instance of Rental with valid input" do
    end
    it "assigns the current date to checkout_date" do
    end
    it "assigns due date as a week from current date" do
    end
    it "throws an error if invalid movie" do
    end
    it "throws an error if invalid customer" do
    end
    it "throws an error if movie inventory is zero" do
    end
    it "if rental successfully created, movie inventory is decreased by one" do
    end
    it "if rental succesfully created, custoer's movies checked out count increased by one" do
    end
  end

  describe "checkin" do
    it "can successfully check a rental back in with valid input" do
    end
    it "increases movie's inventory by one if successfully checked back in" do
    end
    
  end
end
