require "test_helper"

describe MoviesController do

  MOVIE_FIELDS = ["id", "release_date", "title"]
  
  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'
    
    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    
    return body
  end
  
  
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
      body = check_response(expected_type: Hash)
      
      #assert
      expect(body.keys.sort).must_equal MOVIE_FIELDS
    end
    
  end
  
end#end of moviescontroller
