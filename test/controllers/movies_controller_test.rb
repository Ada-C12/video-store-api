require "test_helper"
MOVIE_KEYS_JSON = ["id", "title", "overview", "release_date", "inventory", "available_inventory"]

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
        expect(movie.keys).must_equal MOVIE_KEYS_JSON
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
    it "responds with JSON and success" do
      movie = movies(:one)
      
      get movie_path(movie)
      body = JSON.parse(response.body)
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "can find a valid movie" do
      movie = movies(:one)
      
      get movie_path(movie)
      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
      expect(body.keys).must_equal MOVIE_KEYS_JSON
      expect(body["title"]).must_equal "Moviea"
      expect(body["id"]).must_equal movie.id
    end

    it "returns not found error if invalid movie" do
      invalid_id = -1
      get movie_path(invalid_id)
      
      body = JSON.parse(response.body)
      
      must_respond_with :not_found 
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal "Not found"     
    end
  end

  describe "create" do

    it "responds with JSON and created status" do
      
      post movies_path, params: {"title" => "Star Wars", "inventory" => 5}
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    it "can create a new valid movie" do

      expect { post movies_path, params: {"title" => "Star Wars", "inventory" => 5} }.must_differ 'Movie.count', 1
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Hash
      expect(body.keys).must_equal ["id"]
    end 

    it "will respond with bad_request for invalid data" do

      params = {"title" => "Star Wars"}
      
      expect { post movies_path, params: params }.wont_change "Customer.count"
      body = JSON.parse(response.body)
      
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      expect(body["errors"].keys).must_include "inventory"
    end
  end
end


