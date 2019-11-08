require "test_helper"

describe RentalsController do
  describe "checkout" do
    let(:customer) {
      customers(:janice)
    }
    let(:movie) {
      movies(:movie1)
    }
    let(:rental_data) {
      {
        customer_id: customer.id,
        movie_id: movie.id
      }
    }

    it "creates a new Rental with valid input" do
      expect{post checkout_path, params: rental_data}.must_change 'Rental.count', 1
      must_respond_with :ok
    end

    it "assigns the current date to checkout_date" do
      post checkout_path, params: rental_data
      rental = Rental.last
      expect(rental.checkout_date).must_equal Date.today
    end

    it "assigns due date as a week from current date" do
      post checkout_path, params: rental_data
      rental = Rental.last
      expect(rental.due_date).must_equal (Date.today + 7)
    end

    it "throws an error if invalid movie" do
      rental_data[:movie_id] = nil
      expect {post checkout_path, params: rental_data}.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "throws an error if invalid customer" do
      rental_data[:customer_id] = nil
      expect {post checkout_path, params: rental_data}.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "throws an error if movie inventory is zero" do
      rental_data[:movie_id] = movies(:movie3).id
      expect {post checkout_path, params: rental_data}.wont_change "Rental.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "if rental successfully created, movie inventory is decreased by one" do
      post checkout_path, params: rental_data
      movie = Movie.find_by(id: movies(:movie1).id)
      expect(movie.available_inventory).must_equal 2
    end

    it "if rental succesfully created, customer's movies checked out count increased by one" do
      rental_data[:movie_id] = movies(:movie4).id
      post checkout_path, params: rental_data
      customer = Customer.find_by(id: customers(:janice).id)
      expect(customer.movies_checked_out_count).must_equal 3
    end
  end

  describe "checkin" do
    let(:customer) {
      customers(:janice)
    }
    let(:movie) {
      movies(:movie1)
    }
    let(:rental_data) {
      {
        customer_id: customer.id,
        movie_id: movie.id
      }
    }
    it "can successfully check a rental back in with valid input" do
      expect{post checkout_path, params: rental_data}.must_change 'Rental.count', 1
      expect{post checkin_path, params: rental_data}.wont_change 'Rental.count'
      must_respond_with :ok
    end

    it "increases movie's inventory by one if successfully checked back in" do
      post checkout_path(rental_data)
      movie = Movie.find_by(id: movies(:movie1).id)
      expect(movie.available_inventory).must_equal 2

      post checkin_path, params: rental_data
      movie = Movie.find_by(id: movies(:movie1).id)
      expect(movie.available_inventory).must_equal 3
    end

    it "decreases customer's movies checked out count by one" do
      post checkout_path(rental_data)
      customer = Customer.find_by(id: customers(:janice).id)
      expect(customer.movies_checked_out_count).must_equal 3

      post checkin_path, params: rental_data
      customer = Customer.find_by(id: customers(:janice).id)
      expect(customer.movies_checked_out_count).must_equal 2
    end
  end
end
