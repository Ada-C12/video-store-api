require "test_helper"

describe MoviesController do
  INDEX_MOVIE_FIELDS = ["id", "title", "release_date"].sort
  SHOW_MOVIE_FIELDS = ["id", "title", "overview", "release_date", "inventory", "available_inventory"].sort
  
  describe "index" do
    it "returns JSON, success, and a list of movies" do
      # the route
      get movies_path
      
      # check that the content type of the header is JSON
      # check the response code
      # check that the body is a list
      body = check_response(expected_type: Array, expected_status: :ok)
      # check that the list contains hashes
      # check that the movie hash has the right keys
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal INDEX_MOVIE_FIELDS
      end
      # check length of list against Movie.all.count
      movie_count = Movie.all.count
      expect(body.length).must_equal movie_count
    end
    
    it "returns JSON, success, and an empty list if no movies" do
      Rental.destroy_all
      Movie.destroy_all
      
      # the route
      get movies_path
      
      # check that the content type of the header is JSON
      # check the response code
      # check that the body is a list
      body = check_response(expected_type: Array, expected_status: :ok)
      # check that the list contains hashes
      # check that the movie hash is empty
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.empty?).must_equal true
      end
      # check length of list against Movie.all.count
      movies_count = Movie.all.count
      expect(body.length).must_equal movies_count
    end
  end
  
  describe "show" do
    it "returns JSON, success, and movie data for valid movie" do
      # get a movie
      movie = movies(:m_1)
      
      # the route
      get movie_path(movie.id)
      
      # check the content type and response code
      body = check_response(expected_type: Hash, expected_status: :found)
      # binding.pry
      # check that keys are correct
      expect(body.keys.sort).must_equal SHOW_MOVIE_FIELDS
      # check that each value matches the fixture value
      expect(body["id"]).must_equal movie.id
      expect(body["title"]).must_equal movie.title
      expect(body["overview"]).must_equal movie.overview
      expect(body["release_date"]).must_equal movie.release_date.to_s
      expect(body["inventory"]).must_equal movie.inventory
      expect(body["available_inventory"]).must_equal movie.inventory
    end
    
    it "returns JSON, not_found, and error message for invalid movie" do
      # the route
      get movie_path(-9)
      
      # content type and response code not_found
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      
      # check the message that's returned
      expect(body['errors'].keys).must_include "id"
    end
  end
end
