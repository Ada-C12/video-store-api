require "test_helper"

describe MoviesController do
  describe "index" do
    it "responds with JSON and success" do
      get movies_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with an expected list of movies" do
      get movies_path

      body = JSON.parse(response.body)
      expect _(body).must_be_instance_of Array
      expect _(body.size).must_equal Movie.count

      body.each do |movie_info|
        expect _(movie_info).must_be_instance_of Hash
        expect _(movie_info.keys.sort).must_equal ["id", "release_date", "title"]
      end
    end

    it "responds with an expected list of movies when there's no movies" do
      Movie.destroy_all
      get movies_path

      body = JSON.parse(response.body)
      expect _(body).must_be_instance_of Array
      expect _(body).must_be_empty
    end
  end

  describe "show" do
    let(:valid_movie) {movies(:movie1)}

    it "responds with JSON and success" do
      get movie_path(valid_movie.id)

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end 

    it "responds with the expected movies info for valid input" do
      get movie_path(valid_movie.id)

      body = JSON.parse(response.body)
      expect _(body).must_be_instance_of Hash
      expect _(body.keys.sort).must_equal ["available_inventory", "inventory", "overview", "release_date", "title"]
    end


    it "sends back not_found if the movie doesn't exist" do
      get movie_path(-1)

      body = JSON.parse(response.body)

      expect _(body).must_be_instance_of Hash
      must_respond_with :not_found
      expect _(body.keys).must_include "errors"
    end
  end
end
