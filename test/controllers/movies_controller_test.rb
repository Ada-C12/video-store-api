require "test_helper"

describe MoviesController do
  describe "index" do
    it "responds with JSON and success" do
      get movies_path
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "responds with an array of movie hashes" do
      get movies_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal ["id", "release_date", "title"]
      end
    end
    
    it "will respond with an empty array when there are no movies" do
      Movie.destroy_all
      
      get movies_path
      body = JSON.parse(response.body)
      
      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end
  
  describe "show" do
    it "retrieves one movie" do
      movie = Movie.first
      
      get movie_path(movie)
      body = JSON.parse(response.body)
      
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal ["id", "inventory", "overview", "release_date", "title"]
    end
    
    it "sends back not found if the movie does not exist" do
      get movie_path(-1)
      body = JSON.parse(response.body)
      
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys).must_include "errors"
      expect(body["errors"]["id"]).must_equal ["no movie by ID: -1"]
    end
  end
end
