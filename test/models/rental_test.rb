require "test_helper"

describe Rental do
  let(:one) {rentals(:one)}
  
  describe "relations" do
    it "belongs to a customer" do
      _(one).must_respond_to :customer
      _(one.customer).must_be_kind_of Customer
    end
    
    it "belongs to a movie" do
      _(one).must_respond_to :movie
      _(one.movie).must_be_kind_of Movie
    end
  end
  
  describe "custom methods" do
    describe "checkout_dates" do 
      it "sets the checkout date and due date" do
        one.checkout_dates
        
        expect(one.checkout_date).must_be_kind_of ActiveSupport::TimeWithZone
        expect(one.due_date).must_equal one.checkout_date + 7
      end
    end
    
    describe "change_due_date" do 
      it "sets the due date back to nil" do
        one.checkout_dates
        expect(one.due_date).must_equal one.checkout_date + 7
        
        one.check_in
        assert_nil(one.due_date)
      end
    end
  end
end