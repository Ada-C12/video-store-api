require "test_helper"

describe Customer do 
  let (:new_customer) { Customer.new(name: "Janice") }
  let (:new_movie1) { Movie.create(title: "Gone", inventory: 2) }
  let (:new_movie2) { Movie.create(title: "American Beauty", inventory: 3) }

  describe "initialize" do
    it "can be instantiated" do
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
        new_customer.save
        new_customer.name = nil
        
        expect(new_customer.valid?).must_equal false
        expect(new_customer.errors.messages).must_include :name
        expect(new_customer.errors.messages[:name]).must_equal ["can't be blank"]
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
    end

    it "can have many movies" do
      # Arrange
      new_customer.save
      new_rental1 = Rental.create(customer_id: new_customer.id, movie_id: new_movie1.id)
      new_rental2 = Rental.create(customer_id: new_customer.id, movie_id: new_movie2.id)
      
      # Assert
      expect(new_customer.movies.count).must_equal 2
    end

    # it "can set a product through 'product'" do
    #   review = Review.new(reviewer: "random", comment: "nothing", rating: 5)

    #   review.product = products(:cucumber)

    #   expect(review.product_id).must_equal products(:cucumber).id
    #   expect(review.valid?).must_equal true
    # end

    # it "can set a product through 'product_id'" do
    #   review = Review.new(reviewer: "random", comment: "nothing", rating: 5)

    #   review.product_id = products(:rose).id

    #   expect(review.product).must_equal products(:rose)
    #   expect(review.valid?).must_equal true
    # end
  end
end
