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

    it "will create a new instance of a rental" do
      # rental = Rental.new(
      #   checkout_date: Time.now,
      #   due_date: Time.now + 7,
      #   movie: movies(:movie1),
      #   customer: customers(:customer1),
      # )
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
      
      must_respond_with :created
    end

    it "will have the correct attributes" do
    end

    it "will not create a rental with missing attributes" do
    end

    it "will reduce the inventory of a movie by 1" do
    end

    it "will not rent a movie that is out of stock" do
    end


  end
end
