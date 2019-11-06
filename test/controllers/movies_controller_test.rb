require "test_helper"

describe MoviesController do
  describe "index" do
    it "responds with JSON and success" do
      get movies_path
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "responds with an array of customer hashes" do
      get movies_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal ["id", "release_date", "title"]
      end
    end
    
    it "will respond with an empty array when there are no customers" do
      Movie.destroy_all
      
      get movies_path
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end
  
  describe "show" do
    it "responds with json and success" do
      get movie_path(id: Movie.first.id)
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "responds with expected movie information" do 
      get movie_path(id: Movie.first.id)
      
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal ["title", "overview", "release_date", "inventory"].sort
    end
    
    it "responds with error message and success if nonexistent movie" do
      get movie_path(id: -1)
      
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body.keys).must_equal ["errors"]
    end
  end
end
