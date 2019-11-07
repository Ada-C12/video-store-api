require "test_helper"

describe MoviesController do
  it "responds with an array of movie hashes" do
    # Act
    get movies_path
    
    # Get the body of the response
    body = JSON.parse(response.body)
    
    # Assert
    expect(body).must_be_instance_of Array
    
    body.each do |movie|
      expect(movie).must_be_instance_of Hash
      expect(movie.keys.sort).must_equal ["available_inventory", "id", "inventory", "overview", "release_date", "title"]
    end
  end
  
  it "shows a certain movie page" do
    movie = movies(:one)
    
    get movie_path(movie.id)
    body = JSON.parse(response.body)
    
    expect(response.header['Content-Type']).must_include 'json'
    must_respond_with :ok
    expect(body).must_be_instance_of Hash
    expect(body.keys.sort).must_equal ["available_inventory", "id", "inventory", "overview", "release_date", "title"]
  end
  
  it "returns a not found error for an invalid movie" do
    invalid_id = -100
    
    get movie_path(invalid_id)
    body = JSON.parse(response.body)
    
    expect(body).must_be_instance_of Hash
    expect(body["errors"]).must_equal "Not found"
  end
end


