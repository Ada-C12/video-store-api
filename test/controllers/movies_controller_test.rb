require "test_helper"

describe MoviesController do
  def check_response(expected_type:, expected_status:)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

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
        expect(movie.keys.sort).must_equal ["id", "release_date", "title"]
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
    it "responds with a JSON and a success" do
      get movie_path(movies(:movie1))
      must_respond_with :success
    end

    it "responds with info about that movie" do
      get movie_path(movies(:movie1))

      body = check_response(expected_type: Hash, expected_status: :success)
      expect(body["title"]).must_equal "Titanic 2"
      expect(body["overview"]).must_equal "The door wasn't big enough for two."
    end

    it "sends back a not found when the movie doesn't exist" do
      get movie_path(-1)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_equal "not_found"
    end
  end

  describe "create" do 
    it "can create a new movie" do
      movie_data = {
        movie: {
          title: "Cinderella",
          overview: "A Disney classic",
          release_date: Time.new(1992,1,1),
          inventory: 6,
        }
      }

      expect {
        post movies_path, params: movie_data
      }.must_differ "Movie.count", 1
      body = JSON.parse(response.body)
      expect(body.keys).must_include "id"
      must_respond_with :ok
    end

    it "won't create a movie given bad data" do
      movie_data = {
        movie: {
          title: nil,
          overview: "A Disney classic",
          release_date: Time.new(1992,1,1),
          inventory: 6,
        }
      }

      expect {
        post movies_path, params: movie_data
      }.wont_change "Movie.count"

      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "title"
    end



  end



end
