require "test_helper"
MOVIE_KEYS = ["id", "release_date", "title"]

describe MoviesController do
  describe "index" do
    it "responds with an array of movie hashes" do
      get movies_path
      body = check_response(expected_type: Array)
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal MOVIE_KEYS
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
      expect(body.keys.sort).must_equal MOVIE_KEYS
      expect(body["title"]).must_equal movie.title
    end
  end

  describe "create" do
    let(:movie_data) {
    {
    movie: {
    title: "Birds",
    overview: "Lots of birds",
    release_date: Date.new,
    inventory: 5
    }}}

    it "can create a new movie" do
      expect{post movies_path, params: movie_data}.must_differ 'Movie.count', 1

      must_respond_with :created
    end

    it "will respond with bad_request for invalid data" do
      movie_data[:movie][:title] = nil

      expect {post movies_path, params: movie_data}.wont_change "Movie.count"

      must_respond_with :bad_request

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body["errors"].keys).must_include "title"
    end
  end
end
