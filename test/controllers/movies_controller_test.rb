require "test_helper"

MOVIE_FIELDS = ["available_inventory", "inventory", "overview", "release_date", "title"]

describe MoviesController do
  describe "index" do
    it "responds with JSON and success" do
      get movies_path

      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :ok
    end
    it "responds with the expected list of movies" do
      get movies_path

      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Array
      expect(body.size).must_equal Movie.count
      body.each do |movie_hash|
        expect(movie_hash).must_be_instance_of Hash 
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
    it "responds with JSON and Success" do
      movie = movies(:movie1)
      get movie_path(movie.id)

      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :ok
    end
    it "retrieves one movie" do
      movie = movies(:movie1)
      get movie_path(movie)
      body = JSON.parse(response.body)

      expect(body.keys.sort).must_equal MOVIE_FIELDS
    end
    it "responds with a bad request error given an invalid movie id" do
      get movie_path(-1)

      expect(response.header["Content-Type"]).must_include "json"
      must_respond_with :bad_request
    end
  end

  describe "create" do 
    before do 
      @new_movie = {
        title: "test_title",
        overview: "test_overview",
        available_inventory: 10,
        inventory: 10,
        release_date: 2006-10-01
      }
    end
    
    it "responds with ok status when given valid information" do 
      expect { 
        post movies_path, params: @new_movie
       }.must_differ "Movie.count", 1

      must_respond_with :ok
      body = JSON.parse(response.body)
      expect(body.keys).must_equal ["id"]

    end

    it "responds with BAD request when given invalid information" do 
      no_title_movie = @new_movie
      no_title_movie[:title] = nil

      expect { 
        post movies_path(@new_movie)
      }.wont_change "Movie.count"

      must_respond_with :bad_request
      body = JSON.parse(response.body)
      expect(body['errors']).must_include "BAD Request"
    end
  end
end
