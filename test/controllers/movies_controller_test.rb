require "test_helper"

describe MoviesController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  # describe "index" do 
  #   it "responds with an array of pet hashes" do
  #     # Act
  #     get movies_path
  
  #     # Get the body of the response
  #     body = JSON.parse(response.body)
  
  #     # Assert
  #     expect(body).must_be_instance_of Array
  #     body.each do |movie|
  #       expect(movie).must_be_instance_of Hash
  #       expect(pet.keys.sort).must_equal 
  #     end
  #   end
  # end 


  describe "show" do
    it "responds with a JSON and a success" do
      get movie_path(movies(:movie1))

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with info about that movie in a nested array" do
    end

    it "sends back a not found when the movie doesn't exist" do
    end
  end

end
