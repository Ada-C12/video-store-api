require "test_helper"

describe MoviesController do

  MOVIE_FIELDS = ["id", "release_date", "title"]
  
  # def check_response(expected_type:, expected_status: :success)
  #   must_respond_with expected_status
  #   expect(response.header['Content-Type']).must_include 'json'
    
  #   body = JSON.parse(response.body)
  #   expect(body).must_be_kind_of expected_type
    
  #   return body
  # end
  
  
  describe "index" do 
    
    it "responds with JSON and success" do 
      # Act
      get movies_path
      
      # Assert
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    
    it "responds with an array of movie hashes" do 
      # Act
      get movies_path 
      body = JSON.parse(response.body)
      
      # Assert
      expect(body).must_be_instance_of Array 
      expect(body[0]).must_be_instance_of Hash 
    end
    
    it "will respond with an empty array if there are no movies" do 
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
    it "will retrieve one single movie" do
      #arrange 
      good_movie = Movie.first
      
      #act
      get movie_path(good_movie)
      body = JSON.parse(response.body)
      
      #assert
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
      expect(body).must_be_instance_of Hash 
      expect(body.keys).must_equal ["title", "overview", "release_date", "inventory", "available_inventory"]
    end

    it "will send back not found if movie does not exist" do 
      # Act
      get movie_path(-1)
      body = JSON.parse(response.body)


      # Assert
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash 
      expect(body.keys).must_include "errors"
    end
  end

  describe "create" do 
    before do 
      # Arrange
      @movie_params = {
        movie: {
          title: "The Grinch Who Stole Christmas",
          overview: "His heart is 2 sizes too small",
          release_date: 12-01-1008,
          inventory: 45
        }
      }
    end
    it "can create a new movie" do 
      # Act
      
      expect {
        post movies_path(params: @movie_params)

        # Assert
      }.must_differ 'Movie.count'

      # Assert
      body = JSON.parse(response.body)
      must_respond_with :created 
      expect(body).must_be_instance_of Hash 
    end

    it "will respond with a bad request for invalid data" do 
      # Arrange
      @movie_params[:movie][:title] = nil

      # Act/ Assert
      expect {post movies_path(params: @movie_params)}.wont_change "Movie.count"
      body = JSON.parse(response.body)

      # Assert
      must_respond_with :not_found
      expect(body["errors"]).must_equal ["Not Found"]
    end
  end
  
end#end of moviescontroller
