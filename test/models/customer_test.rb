require "test_helper"

describe Customer do 
  let (:new_customer) { Customer.new(name: "Janice") }
  let (:new_movie1) { Movie.create(title: "Gone", inventory: 2) }
  let (:new_movie2) { Movie.create(title: "American Beauty", inventory: 3) }

  describe "initialize" do
    it "can be instantiated if it has valid information" do
      expect(new_customer.valid?).must_equal true
    end
    
    it "will have the required fields" do
      CUSTOMER_KEYS.each do |field|
        expect(new_customer).must_respond_to field
      end
    end
  end

  describe "validations" do
    describe "name" do
      it "must have a name" do
        new_customer.name = nil
        
        expect(new_customer.valid?).must_equal false
        expect(new_customer.errors.messages).must_include :name
        expect(new_customer.errors.messages[:name]).must_equal ["can't be blank"]
      end
    end

    describe "movies_checked_out_count" do
      it "must have movies_checked_out_count" do
        new_customer.movies_checked_out_count = nil 
        
        expect(new_customer.valid?).must_equal false
        expect(new_customer.errors.messages).must_include :movies_checked_out_count
        expect(new_customer.errors.messages[:movies_checked_out_count]).must_equal ["is not a number"]
      end
      
      it "must be greater or equal to zero" do
        new_customer.movies_checked_out_count = -1
        
        expect(new_customer.valid?).must_equal false
        expect(new_customer.errors.messages).must_include :movies_checked_out_count
        expect(new_customer.errors.messages[:movies_checked_out_count]).must_equal ["must be greater than or equal to 0"]
      end
    end
  end
  
  describe "relationships" do
    it "can have many rentals" do
      # Arrange
      new_customer.save
      new_rental1 = Rental.create(customer_id: new_customer.id, movie_id: new_movie1.id)
      new_rental2 = Rental.create(customer_id: new_customer.id, movie_id: new_movie2.id)
      
      # Assert
      expect(new_customer.rentals.count).must_equal 2
      expect((new_customer.rentals).include?(new_rental1)).must_equal true
      expect((new_customer.rentals).include?(new_rental2)).must_equal true
    end

    it "can have many movies through rentals" do
      # Arrange
      new_customer.save
      new_rental1 = Rental.create(customer_id: new_customer.id, movie_id: new_movie1.id)
      new_rental2 = Rental.create(customer_id: new_customer.id, movie_id: new_movie2.id)
      
      # Assert
      expect(new_customer.movies.count).must_equal 2
      expect((new_customer.movies).include?(new_movie1)).must_equal true
      expect((new_customer.movies).include?(new_movie2)).must_equal true
    end
  end
end
