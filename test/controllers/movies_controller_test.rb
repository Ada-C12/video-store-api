require "test_helper"

describe MoviesController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe "index" do 
    it "responds with an array of pet hashes" do
      # Act
      get movies_path
  
      # Get the body of the response
      body = JSON.parse(response.body)
  
      # Assert
      expect(body).must_be_instance_of Array
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(pet.keys.sort).must_equal 
      end

  end 

end
