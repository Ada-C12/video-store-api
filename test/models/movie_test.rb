require "test_helper"

describe Movie do

  let (:new_movie) { movies(:one) }
  # let (:new_movie1) { Movie.create(title: "Gone", inventory: 2) }
  # let (:new_movie2) { Movie.create(title: "American Beauty", inventory: 3) }

  describe "initialize" do
    it "can be instantiated if it has valid information" do
      expect(new_movie.valid?).must_equal true
    end
    
    it "will have the required fields" do
      MOVIE_KEYS.each do |field|
        expect(new_movie).must_respond_to field
      end
    end
  end

  describe "validations" do
    describe "title" do
      it "must have a title" do
        new_movie.title = nil
        
        expect(new_movie.valid?).must_equal false
        expect(new_movie.errors.messages).must_include :title
        expect(new_movie.errors.messages[:title]).must_equal ["can't be blank"]
      end
    end

    describe "inventory" do
      it "must have a inventory and be a number" do
        new_movie.inventory = nil
        
        expect(new_movie.valid?).must_equal false
        expect(new_movie.errors.messages).must_include :inventory
        expect(new_movie.errors.messages[:inventory]).must_equal ["is not a number"]
      end

      it "must have be greater or equal to zero" do
        new_movie.inventory = -1
        
        expect(new_movie.valid?).must_equal false
        expect(new_movie.errors.messages).must_include :inventory
        expect(new_movie.errors.messages[:inventory]).must_equal ["must be greater than or equal to 0"]
      end


    end
  end
  
  # describe "relationships" do
  #   it "can have many rentals" do
  #     # Arrange
  #     new_customer.save
  #     new_rental1 = Rental.create(customer_id: new_customer.id, movie_id: new_movie1.id)
  #     new_rental2 = Rental.create(customer_id: new_customer.id, movie_id: new_movie2.id)
      
  #     # Assert
  #     expect(new_customer.rentals.count).must_equal 2
  #     expect((new_customer.rentals).include?(new_rental1)).must_equal true
  #     expect((new_customer.rentals).include?(new_rental2)).must_equal true
  #   end

  #   it "can have many movies through rentals" do
  #     # Arrange
  #     new_customer.save
  #     new_rental1 = Rental.create(customer_id: new_customer.id, movie_id: new_movie1.id)
  #     new_rental2 = Rental.create(customer_id: new_customer.id, movie_id: new_movie2.id)
      
  #     # Assert
  #     expect(new_customer.movies.count).must_equal 2
  #     expect((new_customer.movies).include?(new_movie1)).must_equal true
  #     expect((new_customer.movies).include?(new_movie2)).must_equal true
  #   end
  # end


  
  # it "have created a relationship with Customer" do
  #   movie = Movie.create(title: "futurama", inventory: 12)
  #   customer = Customer.create(name: "John")
  
  #   movie.customers << customer
  
  #   Rental.first.customer.should == movie
  #   Rental.first.customer.should == customer
  # end
  
  # it "has customers" do
  #   movie = Movie.create(title: "futurama", inventory: 12)
  #   customer = Customer.create(name: "John")
  
  #   movie.customers << customer
  
  #   movie.customer.should == [customer]
  # end
end
