require "test_helper"

describe RentalsController do
  describe "check-out" do 
    let(:rental_data) {
      {
        rental: {
          customer_id: Customer.first.id,
          movie_id: Movie.first.id,
          check_out_date: Date.today,
          due_date: (Date.today) + 7,
          check_in_date: nil
        }
      }
    }


    it "can check-out a movie" do 
      # Act
      expect {
        post check_out_path(params: rental_data)
        # binding.pry
        # Assert
      }.must_differ "Rental.count", 1
      

      # Assert
      body = JSON.parse(response.body)
      must_respond_with :ok 
      expect(body).must_be_instance_of Hash 
    end

    it "cannot check-out a movie for invalid params" do 
      # Arrange
      rental_data[:rental][:customer_id] = nil


      # Act
      expect {
        post check_out_path(params: rental_data)
        # Assert
      }.wont_change "Rental.count"

      # Act/ Assert
      body = JSON.parse(response.body)
      must_respond_with :not_found
      expect(body["errors"]).must_equal ["Not Found"]
    end

  end

  describe "checkin" do 
    let(:rental_data) {
      {
        rental: {
          customer_id: Customer.first.id,
          movie_id: Movie.first.id,
          check_out_date: Date.today,
          due_date: (Date.today) + 7,
          check_in_date: Date.today
        }
      }
    }
    it "can check-in a movie" do  
      # Act
      expect {
        post check_in_path(params: rental_data)
      }.must_differ "Rental.count", 1
    end

    it "cannot check-in a movie for invalid params" do 
      # Arrange
      rental_data[:rental][:movie_id] = nil

      # Act
      expect {
        post check_in_path(params: rental_data)
      }.wont_change "Rental.count"

      # Act/ Assert
      # binding.pry
      body = JSON.parse(response.body)
      must_respond_with :not_found
      expect(body["errors"]).must_equal ["Not Found"]
    end


  end
end
