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
end
