require "test_helper"

describe RentalsController do
  before do
    @params = {movie_id: Movie.first.id, customer_id: Customer.first.id}
  end
  
  describe "checkout" do
    it "responds with created status when request is good" do
      expect{post checkout_path, params: @params}.must_differ "Rental.count", 1
      
      must_respond_with :ok
      body = JSON.parse(response.body)
      expect(body.keys).must_equal ["id"]
    end
    
    it "creates a rental" do
      customer = Customer.find_by(id: @params[:customer_id])
      start_count = customer.rentals.count
      
      expect{post checkout_path, params: @params}.must_differ "Rental.count", 1
      
      rental = Rental.last
      
      customer = Customer.find_by(id: @params[:customer_id])
      end_count = customer.rentals.count
      
      expect(rental.customer.id).must_equal @params[:customer_id]
      expect(end_count).must_equal start_count+1
    end
    
  end
  
  describe "checkin" do
    before do
      post checkout_path, params: @params
    end
    
    it "responds with created status when request is good" do
      expect{post checkin_path, params: @params}.wont_change "Rental.count"
      
      must_respond_with :ok
      body = JSON.parse(response.body)
      expect(body.keys).must_equal ["id"]
    end
    
    it "reduces the customer rental count" do
      customer = Customer.find_by(id: @params[:customer_id])
      start_count = customer.movies_checked_out_count
      
      expect{post checkin_path, params: @params}.wont_change "Rental.count"
      
      customer = Customer.find_by(id: @params[:customer_id])
      end_count = customer.movies_checked_out_count
      rental = Rental.last
      
      expect(end_count).must_equal start_count-1
      assert_nil(rental.due_date)
    end
    
    
  end
  
end
