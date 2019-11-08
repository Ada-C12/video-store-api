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

  # describe "status_checkout" do 
  #   it "set status to checked out" do 
  #     new_rental = Rental.new(
  #       customer_id: customers(:customer1),
  #       movie_id: movies(:movie1) 
  #     )

  #     results = Rental.status_checkout(new_rental)
  #     expect(results.status).must_equal "checked out"

  #   end
  # end 
end
