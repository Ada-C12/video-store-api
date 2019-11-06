require "test_helper"

describe RentalsController do
  describe "create" do
    let(:rental_data) {
      {
        rental: {
          movie: :movie_one,
          customer: :cutomer_one,
          checkout_date: Time.now,
          due_date: (Time.now + 5)
        }
      }
    }
    
    it "can create a new rental" do
      expect {
        post rentals_path, params: rental_data
      }.must_differ 'Rental.count', 1
      
      must_respond_with :created
    end
  end
end
