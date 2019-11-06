require "test_helper"

describe MoviesController do
  describe "index" do
    it "responds with JSON and success" do
      get movies_path
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end
    
    it "responds with an array of movie hashes" do
      # Act
      get movies_path
      
      # Get the body of the response
      body = JSON.parse(response.body)
      
      # Assert
      expect(body).must_be_instance_of Array
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal ["id", "release_date", "title"]
      end
    end
    
    it "will respond with an empty array when there are no movies" do
      # Arrange
      Movie.destroy_all
      
      # Act
      get movies_path
      body = JSON.parse(response.body)
      
      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end
  
  describe "show" do
    it "will respond with one movie" do
      movie = movies(:blacksmith)
      
      get movie_path(movie.id)
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      must_respond_with :ok
    end
    
    it "will respond with the correct keys" do
      movie = movies(:blacksmith)
      
      get movie_path(movie.id)
      body = JSON.parse(response.body)
      
      expect(body.keys.sort).must_equal ["id", "inventory", "overview", "release_date", "title"]
      expect(body["title"]).must_equal "Blacksmith Of The Banished"
    end
    
    it "returns a not found error and status for an invalid movie" do
      get movie_path(-1)
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      must_respond_with :not_found
    end
  end
end
