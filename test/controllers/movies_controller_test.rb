require "test_helper"

# A basic test with no parameters, if applicable
# Positive and negative tests for any URI parameters (user ID, movie title)
# Testing around any data in the request body

describe MoviesController do
  describe "index" do
    it "responds with JSON and success" do
      get movies_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with an array of movie hashes" do
      # Act
      get movies_path
  
      # Get the body of the response
      body = JSON.parse(response.body)
  
      # Assert
      expect(body).must_be_instance_of Array
      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal ["id", "release_date", "title"]
      end
    end

    it "will respond with an empty array when there are no movies" do
      # Arrange
      Movie.destroy_all
  
      # Act
      get movies_path
      body = JSON.parse(response.body)
  
      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
    end
  end

  describe "show" do

    it "responds with JSON and success" do
      movie = movies(:titanic)
      get movie_path(movie.id)

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "displays a movie when given an id" do
      #Arrange
      movie = movies(:titanic)
      get movie_path(movie.id)
      

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash

      expect(body["title"]).must_equal "titanic"
      expect(body["release_date"]).must_equal "1991-01-09"
      expect(body["id"]).must_equal movie.id
      expect(body["overview"]).must_equal "a romance tale for the ages"
      expect(body["inventory"]).must_equal 20


      must_respond_with :ok
    end 

    it "returns a 404 error for a movie that doesn't exist" do

      get movie_path(-1)

      body = JSON.parse(response.body)

      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["not found"]
    end 
  
    describe "create" do 

      let(:movie_data) {
      {
          title: 'Momento',
          overview: 'Mind Fuck',
          release_date: '2003-01-02',
          inventory: 20,
          }
      }

      it "responds with JSOn and can create a new movie" do
        expect {
          post movies_path, params: movie_data
        }.must_differ 'Movie.count', 1

        body = JSON.parse(response.body)

        expect(body["id"]).must_be_instance_of Integer
        expect(response.header['Content-Type']).must_include 'json'
        must_respond_with :ok
      end 

      it "responds with a bad request when missing a required field" do
        movie_data[:title] = nil

        expect { post movies_path, params: movie_data}.must_differ 'Movie.count', 0

        must_respond_with :bad_request

        body = JSON.parse(response.body)

        expect(body["errors"]["title"]).must_equal ["can't be blank"]
      end 
    end 
  end 
end
