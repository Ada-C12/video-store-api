require "test_helper"

describe MoviesController do
  MOVIE_FIELDS = ["id", "title", "release_date"].sort
  
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
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
        expect(movie.keys.sort).must_equal MOVIE_FIELDS
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
end
