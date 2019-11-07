require "test_helper"

describe RentalsController do
  describe "check-out" do
    it "creates a rental given valid movie id and valid customer id" do
      # params
      rental_params = {
        customer_id: customers(:c_3).id,
        movie_id: movies(:m_1).id
      }
      # need some comparison dates
      checkout_date = Date.today
      due_date = Date.today + 7
      
      # the route
      # it should update the rental database count
      expect {
        post checkout_path, params: rental_params
      }.must_differ "Rental.count", 1
      
      # returns JSON, status ok, and the new rental's due date
      body = check_response(expected_type: Hash, expected_status: :ok)
      expect(body["due_date"]).must_equal due_date.to_s
      
      # find the rental by new parameters customer id and movie id
      new_rental = Rental.where(customer_id: rental_params[:customer_id], movie_id: rental_params[:movie_id]).first
      # the dates we assign the new rental should be correct
      expect(new_rental.checkout_date).must_equal checkout_date
      expect(new_rental.due_date).must_equal due_date
      
      # find the movie and customer by new rental's id
      movie = Movie.find_by(id: new_rental.movie_id)
      customer = Customer.find_by(id: new_rental.customer_id)
      # we should see the new rental in the customer.rentals list
      # and movie.rentals list of the customer and movie assigned
      expect(movie.rentals).must_include new_rental
      expect(customer.rentals).must_include new_rental
    end
    
    it "returns an error when movie inventory is zero" do
      # should not create an instance of a rental
      # if the movie inventory is zero
      
      # check that the database rental count did not change
      # should return an error and status bad_request
    end
    
    it "returns an error if given invalid movie id" do
      # params
      rental_params = {
        customer_id: customers(:c_3).id,
        movie_id: -1
      }
      
      # route
      # check that the database rental count did not change
      expect {
        post checkout_path, params: rental_params
      }.wont_differ "Rental.count"
      
      # returns JSON, status bad_request, and an error
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body.keys).must_include 'errors'
      expect(body['errors'].keys).must_include 'movie'
    end
    
    it "returns an error if given invalid customer id" do
      # params
      rental_params = {
        customer_id: -1,
        movie_id: movies(:m_1).id
      }
      
      # route
      # check that the database rental count did not change
      expect {
        post checkout_path, params: rental_params
      }.wont_differ "Rental.count"
      
      # returns JSON, status bad_request, and an error
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body.keys).must_include 'errors'
      expect(body['errors'].keys).must_include 'customer'
    end
  end
  
  describe "check-in" do
    it "renders JSON and success when given valid movie id and customer id" do
      # params
      rental_params = {
        customer_id: customers(:c_3).id,
        movie_id: movies(:m_1).id
      }
      
      # the route
      # expect that it won't change rental count
      expect {
        post checkin_path, params: rental_params
      }.wont_differ "Rental.count"
      
      # returns JSON, status bad_request, and ok
      check_response(expected_type: Hash, expected_status: :ok)
    end
    
    it "renders JSON and bad_request when given invalid movie id" do
      # params
      rental_params = {
        customer_id: customers(:c_3).id,
        movie_id: -1
      }
      
      # the route
      # expect that it won't change rental count
      expect {
        post checkin_path, params: rental_params
      }.wont_differ "Rental.count"
      
      # returns JSON, status bad_request, and ok
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body.keys).must_include 'errors'
      expect(body['errors'].keys).must_include 'movie'
    end
    
    it "renders JSON and bad_request when given invalid customer id" do
      # params
      rental_params = {
        customer_id: -1,
        movie_id: movies(:m_1).id
      }
      
      # the route
      # expect that it won't change rental count
      expect {
        post checkin_path, params: rental_params
      }.wont_differ "Rental.count"
      
      # returns JSON, status bad_request, and ok
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body.keys).must_include 'errors'
      expect(body['errors'].keys).must_include 'customer'
    end
  end
end
