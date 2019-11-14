require "test_helper"

describe Movie do
  describe "relationships" do
    before do 
      mariya = customers(:mariya)
      cloudy = customers(:cloudy)
      sara = customers(:sara)
      @up = movies(:up)
      
      rental = Rental.create(customer_id: mariya.id, movie_id: @up.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
      rental2 = Rental.create(customer_id: sara.id, movie_id: @up.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
      rental3 = Rental.create(customer_id: cloudy.id, movie_id: @up.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
      rental4 = Rental.create(customer_id: sara.id, movie_id: @up.id, check_out_date: Date.today, due_date: Date.today + 7, check_in_date: nil)
    end
    
    it "has customers" do 
      expect(@up.customers.count).must_equal 4
    end
    
    it "has rentals" do
      expect(@up.rentals.count).must_equal 4
    end
  end
  
  describe "validations" do 
    before do 
      # Arrange
      @up = movies(:up)
    end
    
    it "has a title" do 
      # Assert
      @up.title.must_equal "up"
    end
    
    it "is invalid with a bad title" do 
      # Arrange
      bad_movie = Movie.new(title: nil, overview: "bad data", release_date: "November 6, 2019", inventory: 5)
      
      # Assert
      expect(bad_movie.valid?).must_equal false
    end
    
    it "has an overview" do 
      # Assert
      @up.overview.wont_be_nil
    end
    
    it "is invalid with no overview" do 
      # Arrange
      bad_movie = Movie.new(title: "Ok", overview: nil, release_date: "November 6, 2019", inventory: 5)
      
      # Assert
      expect(bad_movie.valid?).must_equal false
      
    end 
    
    it "has a release date" do 
      # Assert
      @up.release_date.wont_be_nil
    end
    
    it "is invalid without a release date" do 
      # Arrange
      bad_movie = Movie.new(title: "ok", overview: "bad data", release_date: nil, inventory: 5)
      
      # Assert
      expect(bad_movie.valid?).must_equal false
    end
    
    it "has an inventory" do 
      # Assert
      @up.inventory.must_equal 10
    end
    
    it "allows for a zero inventory amount" do 
      # Arrange
      bad_movie = Movie.new(title: "ok", overview: "bad data", release_date: "November 6, 2019", inventory: 0)
      
      # Assert
      expect(bad_movie.valid?).must_equal true
    end
    
    it "is invalid without an inventory" do 
      # Arrange
      bad_movie = Movie.new(title: "ok", overview: "bad data", release_date: "November 6, 2019", inventory: nil)
      
      # Assert
      expect(bad_movie.valid?).must_equal false
    end
  end #describe validations
end #describe movie
