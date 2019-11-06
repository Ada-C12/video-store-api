require "test_helper"

describe Rental do
  let (:rental) {rentals(:r1)}
  
  describe "validations" do
    
    it "is valid with all fields present and valid" do
      expect(rental.valid?).must_equal true
    end
    
    it "is invalid without a customer_id" do
      rental.customer_id = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :customer_id
    end
    
    it 'is invalid without a customer_id' do
      rental.customer_id = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :customer_id
    end
    
    it 'is invalid without movie_id' do
      rental.movie_id = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :movie_id
    end
    
    
    it 'is invalid when movie_id is not the right datatype' do
      rental.movie_id = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :movie_id
    end
    
    it 'is invalid without a created_at' do
      rental.created_at = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :created_at
    end
    
    it 'is invalid without a updated_at' do
      rental.updated_at = nil
      
      expect(rental.valid?).must_equal false
      expect(rental.errors.messages).must_include :updated_at
    end    
  end
  
  describe "relations" do
    it "can have one or many rentals" do
      rental.must_respond_to :rentals
      rental.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end    
  end
end

