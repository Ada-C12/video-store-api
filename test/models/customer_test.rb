require "test_helper"

describe Customer do
  describe "validations" do
    let(:customer) {customers(:customer_one)}
    
    it "can be created" do
      expect(customer.valid?).must_equal true
    end
    
    it "requires name, postal_cost, registered_at" do
      required_fields = [:name, :postal_code, :registered_at]
      
      required_fields.each do |field|
        customer[field] = nil
        
        expect(customer.valid?).must_equal false
        
        customer.reload
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
end
