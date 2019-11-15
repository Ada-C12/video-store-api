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
      customer = customers(:customer1)
      rental_1 = Rental.new(customer: customer, checkout_date: Time.new(2018, 1, 1), due_date: Time.new(2018, 1, 7))
      rental_2 = Rental.new(customer: customer, checkout_date: Time.new(2018, 1, 1), due_date: Time.new(2018, 1, 7))
      rental_3 = Rental.new(customer: customer, checkout_date: Time.new(2018, 1, 1), due_date: Time.new(2018, 1, 7))

      new_movie.save!
      new_movie = Movie.last

      new_movie.rentals << rental_1
      new_movie.rentals << rental_2
      new_movie.rentals << rental_3

      expect(new_movie.rentals.count).must_be :>, 1

      new_movie.rentals.each do |rental|
        expect(rental).must_be_instance_of Rental
      end
    end
  end

  describe "validations" do
    it "must have a title" do
      new_movie.title = nil
      expect(new_movie.valid?).must_equal false
      expect(new_movie.errors.messages).must_include :title
      expect(new_movie.errors.messages[:title]).must_include "can't be blank"
    end

    it "inventory can't be nil" do
      new_movie.inventory = nil
      expect(new_movie.valid?).must_equal false
      expect(new_movie.errors.messages).must_include :inventory
      expect(new_movie.errors.messages[:inventory]).must_include "can't be blank"
    end
  end

  describe "custom methods" do
    describe "check_inventory" do
      it "will return true if there is more than 0 inventory" do
        movie = movies(:movie1)
        expect(movie.check_inventory).must_equal true
      end

      it "will return false if there is 0 inventory" do
        movie = Movie.create(
          title: "title",
          overview: "Description", 
          release_date: Time.new(2018, 1, 1) ,
          inventory: 0,
        )

        expect(movie.check_inventory).must_equal false
      end
    end
  end
end
