require "test_helper"

describe Rental do
  describe "validations" do
    let(:rental) {rentals(:rental_one)}
    
    it "can be created" do
      expect(rental.valid?).must_equal true
    end
    
    it "requires checkout_date, due_date, customer, movie" do
      required_fields = [:customer_id, :movie_id, :checkout_date, :due_date]
      
      required_fields.each do |field|
        rental[field] = nil
        
        expect(rental.valid?).must_equal false
        
        rental.reload
      end
    end 
  end

  describe "relationships" do
    let(:movie) {movies(:movie_one)}
    let(:customer) {customers(:customer_one)}
    let(:rental) {rentals(:rental_one)}

    it "belongs to a customer" do
      expect(rental.customer).must_be_instance_of Customer
      expect(rental.customer.id).must_equal customer.id
    end

    it "belongs to a movie" do
      expect(rental.movie).must_be_instance_of Movie
      expect(rental.movie.id).must_equal movie.id
    end
  end
end
