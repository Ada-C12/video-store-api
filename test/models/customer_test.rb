require "test_helper"
require "date"
require 'pry'
describe Customer do
  describe "validations" do
    before do
      @customer = customers(:customer_one)
    end
    it "can be created" do
      
      expect(@customer.valid?).must_equal true
    end
    
    it "requires name, postal_cost, registered_at" do
      required_fields = [:name, :postal_code, :registered_at, :phone, :movies_checked_out_count]
      
      required_fields.each do |field|
        @customer[field] = nil
        
        expect(@customer.valid?).must_equal false
        
        @customer.reload
      end
    end 
  end
  
  describe "relationships" do
    let(:movie) {movies(:movie_one)}
    let(:customer) {customers(:customer_one)}
    let(:rental) {rentals(:rental_one)}
    
    it "can have rentals" do
      expect(customer.rentals.first).must_be_instance_of Rental
      expect(customer.rentals.first.id).must_equal rental.id
    end
    
    it "can have moviess through rentals" do
      expect(customer.movies.first).must_be_instance_of Movie
      expect(customer.movies.first.title).must_equal movie.title
    end
  end
  
  describe "customer_checkout" do
    it "can checkout a movie and reduce available inventory" do
      customer = Customer.first
      previous_checked_out_count = customer.movies_checked_out_count
      customer = customer.customer_checkout
      updated_checked_out_count = customer.movies_checked_out_count
      
      expect(updated_checked_out_count - previous_checked_out_count).must_equal 1
    end
    
    it "should not allow a movie to be checked out if the customer does not exist" do
    end
    
    it "should not allow a movie to be checked out if the movie does not exist" do
    end
    
  end
  describe "customer_checkin" do
    it "can checkin a movie and add reduce qty checked out" do
      customer = customers(:customer_one)
      movie_checked_out_start_count = customer.movies_checked_out_count
      
      customer = customer.customer_checkin
      
      expect(movie_checked_out_start_count - customer.movies_checked_out_count).must_equal 1
    end
  end
end
