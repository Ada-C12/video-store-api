require "test_helper"
require 'pry'

describe MoviesController do
  
  describe "index" do
    it "responds with JSON and success" do
      get movies_path
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
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
        expect(movie.keys.sort).must_equal MOVIE_KEYS
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
    it "will show movie info for valid movie" do
      test_movie = movies(:movie_one)
      get movie_path(test_movie)
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      must_respond_with :ok
      expect(body.keys.sort).must_equal MOVIE_KEYS
      
      expect(body["id"]).must_equal test_movie.id
      expect(body["title"]).must_equal test_movie.title
      expect(body["overview"]).must_equal test_movie.overview
      expect(body["release_date"]).must_equal test_movie.release_date.to_s
      expect(body["inventory"]).must_equal test_movie.inventory
      expect(body["available_inventory"]).must_equal test_movie.available_inventory
    end
    
    it "will show error code for invalid movie" do
      invalid_movie = -1
      get movie_path(invalid_movie)
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["not found"]
      must_respond_with :not_found
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        movie: {
          title: "Clue",
          inventory: 4
        }
      }
    }

    it "shouhld create a movie" do
      expect{
        post movies_path, params: movie_data
      }.must_differ 'Movie.count', 1

      must_respond_with :ok
    end

    it "should not create a movie with invalid data, no title" do
      movie_data[:movie][:title] = nil

      expect {
        post movies_path, params: movie_data
      }.wont_differ 'Movie.count'

      must_respond_with :bad_request
    end
  end
end
