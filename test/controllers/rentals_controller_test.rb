require "test_helper"

describe RentalsController do
  describe "checkin" do
    let(:customer) {
      customers(:eminique)
    }
    let(:movie) {
      movies(:titanic)
    }
    
    let(:rental_data) {
      {
          customer_id: customer.id, 
          movie_id: movie.id,
        }
    }
    
    it "responds with JSON and success when passed in valid params and creates new rental" do
      

    end
  end
end
