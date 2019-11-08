require "test_helper"

describe RentalsController do
  describe "check_out" do 
    it "creates a new instance of Rental if given valid data" do 
      movie = movies(:movie1)
      customer = customers(:customer1)

      new_rental = {
        customer_id: customer.id, 
        movie_id: movie.id
      }
      expect{
      post check_out_path(new_rental)
      }.must_differ "Rental.count", 1

      expect(new_rental[:customer_id]).must_equal customer.id
      expect(new_rental[:movie_id]).must_equal movie.id
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
    end
    
    it "renders and error if given invalid data" do 
      movie = movies(:movie1)
      
      new_rental = {
        customer_id: nil, 
        movie_id: movie.id
      }
      expect{
      post check_out_path(new_rental)
      }.wont_change "Rental.count"
      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :bad_request
    end 
  end

   describe "check_in" do 

    # it "can find the rental from the customer and movie" do 
    #   customer = 
    # end


  #   it "increases available inventory by 1" do
  #     customer = customers(:customer1)
  #     movie = movies(:movie1)
  #     rental = rentals(:rental1)

    

  #     post check_in_path(rental)

  #     expect(movie.inventory).must_equal 11
  #   end
  #  end

  #   it "changes the status of the given rental to checked in" do 
  #   customer = customers(:customer1)
  #   movie = movies(:movie1)

  #   test_rental = rentals(:rental1)

  #   post check_in_path(test_rental)

  #   expect(test_rental.status).must_equal "checked in"
  #   end
  

end
