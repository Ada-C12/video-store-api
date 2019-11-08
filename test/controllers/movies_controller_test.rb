require "test_helper"

describe MoviesController do
  MOVIE_FIELDS_INDEX = %w(id release_date title)
  MOVIE_FIELDS_SHOW = %w(id title overview release_date inventory available_inventory)
  
  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'
    
    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end 
  
  describe "index" do 
    it "responds with JSON and success" do 
      get movies_path
      check_response(expected_type: Array, expected_status: :success)
    end
    
    it "responds with an array of movie hashes" do 
      get movies_path
      body = check_response(expected_type: Array)
      
      body.each do |movie|
        expect(movie.keys.sort).must_equal MOVIE_FIELDS_INDEX
      end 
    end 
    
    it "will respond with an empty array when no movies" do 
      Rental.destroy_all
      #probably have to add some state to the movies, like “isDeleted”?
      #We can either leave it like this, or add a field to the model so that we can basically leave a Movie in the movies table but have some way to tell that it’s actually deleted and that the controller should filter it out.
      Movie.destroy_all
      
      get movies_path
      
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end 
  end 
  
  describe "show" do 
    it "retrieves one movie" do 
      movie = Movie.first
      
      get movie_path(movie)
      body = check_response(expected_type: Hash)
      
      expect(body.keys).must_equal MOVIE_FIELDS_SHOW
    end 
    
    it "sends back not found if the movie doesnt exist" do 
      get movie_path(-1)
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body.keys).must_include "errors"
    end 
  end 
  
  describe "create" do 
    let(:movie_data) { 
    {
    title: "Babe 2: Pig in the City",
    inventory: 2,
    overview: "This post-modern gothic addresses themes of loyalty and sacrifice.",
    release_date: Date.new(11-1-20),
    available_inventory: 10
  }
}

it "can create a new movie" do 
  expect {
  post movies_path, params: movie_data
}.must_differ 'Movie.count', 1

body = check_response(expected_type: Hash, expected_status: :ok)

new_movie = Movie.find(body["id"])
expect(body.keys).must_include "id"
end 

it "will respond with bad_request for invalid data" do
  movie_data[:title] = nil
  
  expect {
  post movies_path, params: movie_data
}.wont_change "Movie.count"

body = check_response(expected_type: Hash, expected_status: :bad_request)
expect(body["errors"].keys).must_include "title"
end 
end 
end 
