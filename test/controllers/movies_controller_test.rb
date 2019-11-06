require "test_helper"

describe MoviesController do

  def check_response(expected_type:, expected_status:)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

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

    it "responds with info about that movie" do
      get movie_path(movies(:movie1))

      body = check_response(expected_type: Hash, expected_status: :success)
      expect(body["title"]).must_equal "Titanic 2"
      expect(body["overview"]).must_equal "The door wasn't big enough for two."
    end

    it "sends back a not found when the movie doesn't exist" do
      get movie_path(-1)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_equal "not_found"
    end
  end

end
