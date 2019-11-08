require "test_helper"

describe MoviesController do
  describe "index" do
    it "responds with JSON and success" do
      get movies_path
      
      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :ok
    end
    
    it "responds with an array of movie hashes" do
      get movies_path
      
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal ["id", "title", "release_date"].sort
      end
    end
    
    it "responds with an empty array if there are no movies" do
      Movie.destroy_all
      get movies_path
      
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end
  
  describe "show" do
    it "retrieves one movie" do
      movie = Movie.first
      
      get movie_path(movie.id)
      body = JSON.parse(response.body)
      
      must_respond_with :ok
      expect(response.header["Content-Type"]).must_include "json"
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal ["inventory", "overview", "release_date", "title", "available_inventory"].sort
    end
    
    it "returns a not_found if given an invalid ID" do
      invalid_id = -1
      
      get movie_path(invalid_id)
      body = JSON.parse(response.body)
      
      must_respond_with :not_found
      expect(body).must_be_instance_of Hash
      expect(response.header["Content-Type"]).must_include "json"
      expect(body.keys).must_include "errors"
    end
  end
  
  describe "create" do
    let(:movie_data) {
      {
        title: "new movie",
        overview: "a movie",
        release_date: Date.today,
        inventory: 10,
      }
    }
    
    it "can create a new movie" do
      # binding.pry
      
      expect {
        post movies_path, params: movie_data
      }.must_differ "Movie.count", 1
      must_respond_with :ok
    end
    
    it "will respond with bad_request for invalid data" do
      movie_data[:title] = nil
      
      expect {
        post movies_path, params: movie_data
      }.wont_change "Movie.count"
      
      must_respond_with :bad_request
      
      expect(response.header["Content-Type"]).must_include "json"
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "title"
    end
  end
end
