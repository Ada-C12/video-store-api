require "test_helper"

describe MoviesController do
  describe "index" do
    it "responds with an array of movie hashes" do
      get movies_path
      body = check_response(expected_type: Array)
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal MOVIE_KEYS.sort
      end
    end

    it "will respond with an empty array when there are no movies" do
      Movie.destroy_all
      get movies_path
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end

  describe "show" do
    it "responds with one movie's hash" do
      movie = movies(:movie2)
      get movie_path(movie.id)
      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal MOVIE_KEYS2.sort
      expect(body["title"]).must_equal movie.title
    end

    it "will respond with bad_request for invalid data" do
      get movie_path(-1)
      body = JSON.parse(response.body)

      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys).must_include "errors"
    end
  end

  describe "create" do
    let(:movie_data) {
    {
    title: "Birds",
    overview: "Lots of birds",
    release_date: Date.new,
    inventory: 5}}

    it "can create a new movie" do
      expect{post movies_path, params: movie_data}.must_change 'Movie.count', 1
      must_respond_with :ok
    end

    it "will respond with bad_request for invalid data" do
      movie_data[:title] = nil
      expect {post movies_path, params: movie_data}.wont_change "Movie.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "title"
    end
  end
end
