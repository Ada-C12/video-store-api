require "test_helper"
MOVIE_KEYS = ["id", "release_date", "title"]

describe MoviesController do
  describe "index" do
    it "responds with an array of movie hashes" do
      get movies_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal MOVIE_KEYS
      end
    end
    
    it "will respond with an empty array when there are no movies" do
      Movie.destroy_all
      get movies_path
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end
  
  describe "show" do
    it "responds with one movie's hash" do
      movie = movies(:movie2)
      get movie_path(movie.id)
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal MOVIE_KEYS
      expect(body["title"]).must_equal movie.title
    end
  end
end
