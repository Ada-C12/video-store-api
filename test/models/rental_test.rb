require "test_helper"

describe Rental do
  describe 'relations' do
    it 'belongs to a movie' do
      expect(rentals(:one)).must_respond_to(:movie)
      expect(rentals(:one).movie).must_be_instance_of Movie
    end 

    it 'belongs to a customer' do
      expect(rentals(:one)).must_respond_to(:customer)
      expect(rentals(:one).customer).must_be_instance_of Customer
    end
  end

  describe 'model methods' do
    describe 'checkout' do
      it "should respond with JSON, created, & store a rental in the db for an existing customer and movie" do

      end

      it "should decrement the available inventory of movies" do
      end

      it "should increment the number of movies checked out for a customer" do
      end

      it "customer but no movie" do
      end

      it "movie but no customer" do
      end

      it "no movie no customer" do
      end

      it "won't check out an unavailable movie" do

      end
    end

    describe 'checkin' do

    end
  end
end
