require "test_helper"

describe Movie do
  let(:new_movie) {
    new_movie = Movie.new(
      title: "Titanic",
      overview: "The door wasn't big enough for two.",
      release_date: Time.new(2018, 1, 1),
      inventory: 10,
    )
  }

  describe "instantiation" do
    it "can instantiate a valid product" do
      expect(new_movie.save).must_equal true
    end
  end
  
  describe "relationships" do
    it "can have many rentals" do
      # rental_1 = Rental.new(checkout_date: Time.new(2018, 1, 1), due_date: Time.new(2018, 1, 7),)
      # rental_2 = Rental.new(checkout_date: Time.new(2018, 1, 1), due_date: Time.new(2018, 1, 7),)
      # rental_3 = Rental.new(checkout_date: Time.new(2018, 1, 1), due_date: Time.new(2018, 1, 7),)
      
      # new_movie.save!
      # new_movie = Movie.last

      # new_movie.rentals << rental_1
      # new_movie.rentals << rental_1
      # new_movie.rentals << rental_1

      # expect(new_movie.rentals.count).must_be :>, 1
      
      # new_movie.rentals.each do |rental|
      #   expect(rental).must_be_instance_of Rental
      # end
    end
  end

  describe "validations" do
    it "must have a title" do
    end

    it "inventory can't be nil" do
    end
  end


end
