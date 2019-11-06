require "test_helper"

describe MoviesController do
  
  describe "index" do 
    
    it "responds with JSON and success" do 
      # Act
      get movies_path
      
      # Assert
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
    
    MOVIE_FIELDS = ["id", "release_date", "title"]
    
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
  
end#end of moviescontroller
