require "test_helper"
require 'pry'

describe Movie do
  describe "validations" do
    let(:movie) {movies(:movie_one)}
    
    it "can be created" do
      expect(movie.valid?).must_equal true
    end
    
    it "requires title, inventory" do
      required_fields = [:title, :inventory]
      
      required_fields.each do |field|
        movie[field] = nil
        
        expect(movie.valid?).must_equal false
        
        movie.reload
      end
    end 
    
    it "requires a numeric inventory" do
      movie.inventory = ""
      
      expect(movie.valid?).must_equal false
    end
  end
  
  describe "relationships" do
    let(:movie) {movies(:movie_one)}
    let(:customer) {customers(:customer_one)}
    let(:rental) {rentals(:rental_one)}
    
    it "can have rentals" do
      expect(movie.rentals.first).must_be_instance_of Rental
      expect(movie.rentals.first.id).must_equal rental.id
    end
    
    it "can have customers through rentals" do
      expect(movie.customers.first).must_be_instance_of Customer
      expect(movie.customers.first.name).must_equal customer.name
    end
  end
  
  describe "movie_checkout" do
    it "can checkout a movie and reduce available inventory" do
      movie = movies(:movie_one)
      updated_movie = movie.movie_checkout
      
      expect(movie.available_inventory - updated_movie.available_inventory).must_equal 1
    end
    
    it "should not allow a movie to be checked out if the inventory is less than 1" do
      movie = movies(:movie_two)
      updated_movie = movie.movie_checkout
      
      # body = JSON.parse(response.body)
      # expect(body).must_be_instance_of Hash
      # expect(body["errors"]).must_equal ["no inventory available"]
      # must_respond_with :bad_request
      
      expect(movie.available_inventory - updated_movie.available_inventory).must_equal 0
    end
    
    it "should not allow a movie to be checked out if the movie does not exist" do
    end
    
  end
end
