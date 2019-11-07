require "test_helper"

describe MoviesController do
  MOVIE_FIELDS = ['id', 'release_date', 'title']

  describe "index" do 
    it "responds with JSON and success" do
      get movies_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "will give a list of all movies" do
      get movies_path

      body = JSON.parse(response.body)
  
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal Movie.count

      body.each do |movie_hash| 
        expect(movie_hash).must_be_instance_of Hash
        expect(movie_hash.keys.sort).must_equal MOVIE_FIELDS
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
end
