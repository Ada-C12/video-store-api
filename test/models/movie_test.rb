require "test_helper"

describe Movie do
  
  let (:new_movie) { movies(:one) }
  let (:new_customer) { customers(:one) }
  let (:new_customer2) { customers(:two) }
  
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

      it "must be unique" do
        new_movie.save
        duplicate_title = new_movie.title   
        duplicate_movie = Movie.create(title: duplicate_title, inventory: 5)
        
        expect(duplicate_movie.valid?).must_equal false
        expect(duplicate_movie.errors.messages).must_include :title
        expect(duplicate_movie.errors.messages[:title]).must_equal ["has already been taken"]
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

    describe "available_inventory" do
      it "must have available_inventory and be a number" do
        new_movie.available_inventory = nil
        
        expect(new_movie.valid?).must_equal false
        expect(new_movie.errors.messages).must_include :available_inventory
        expect(new_movie.errors.messages[:available_inventory]).must_equal ["is not a number"]
      end
      
      it "must be greater or equal to zero" do
        new_movie.available_inventory = -1
        
        expect(new_movie.valid?).must_equal false
        expect(new_movie.errors.messages).must_include :available_inventory
        expect(new_movie.errors.messages[:available_inventory]).must_equal ["must be greater than or equal to 0"]
      end
    end
  end
  
  describe "relationships" do
    it "can have many rentals" do
      # Arrange
      new_rental1 = Rental.create(customer_id: new_customer.id, movie_id: new_movie.id)
      new_rental2 = Rental.create(customer_id: new_customer.id, movie_id: new_movie.id)
      
      # Assert
      expect(new_movie.rentals.count).must_equal 2
      expect((new_movie.rentals).include?(new_rental1)).must_equal true
      expect((new_movie.rentals).include?(new_rental2)).must_equal true
    end
    
    it "can have many customers through rentals" do
      # Arrange
      new_rental1 = Rental.create(customer_id: new_customer.id, movie_id: new_movie.id)
      new_rental2 = Rental.create(customer_id: new_customer2.id, movie_id: new_movie.id)
      
      # Assert
      expect(new_movie.customers.count).must_equal 2
      expect((new_movie.customers).include?(new_customer)).must_equal true
      expect((new_movie.customers).include?(new_customer2)).must_equal true
    end
  end
end
