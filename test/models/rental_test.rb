require "test_helper"

describe Rental do
  describe "relations" do
    let(:current_rental) { rentals(:rental1)}

    it "can get the movie from 'movie'" do
      expect(current_rental.movie).must_be_instance_of Movie
    end
    it "can get the customer from 'customer'" do
      expect(current_rental.customer).must_be_instance_of Customer
    end
  end

  describe "due_date" do 
    it "will set the due date to the correct date given valid data" do
      new_rental = Rental.new(
        customer_id: customers(:customer1),
        movie_id: movies(:movie1) 
      )
      results = Rental.due_date(new_rental)

      expect(results).wont_be_nil
      expect(results.due_date).must_equal Date.today + 7.days
    end
  end

  describe "validations" do 

    it "is invalid without a customer_id" do 
      rental = rentals(:rental1)
      rental.customer_id = nil

      result = rental.valid?

      expect(result).must_equal false
    end

    it "is valid with a numeric customer_id" do 
      rental = rentals(:rental1)

      result = rental.valid?

      expect(result).must_equal true
    end

    it "is invalid with a customer_id that is not a number" do
     rental = rentals(:rental1)

      rental.customer_id =  "cat"

      result = rental.valid?

      expect(result).must_equal false
    end

    it "is invalid without a movie_id" do 
      rental = rentals(:rental1)
      rental.movie_id = nil

      result = rental.valid?

      expect(result).must_equal false
    end

    it "is valid with a numeric movie_id" do 
      rental = rentals(:rental1)

      result = rental.valid?

      expect(result).must_equal true
    end

    it "is invalid with a movie_id that is not a number" do
     rental = rentals(:rental1)

      rental.movie_id =  "cat"

      result = rental.valid?

      expect(result).must_equal false
    end
  end
end
