require "test_helper"

MOVIE_FIELDS = %w(id title overview release_date inventory available_inventory).sort

describe MoviesController do
  
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
      check_response(expected_type: Array)
    end

    it "responds with an array of movie array" do
      # Act
      get movies_path

      # Assert
      body = check_response(expected_type: Array)

      body.each do |movie|
        expect(movie.keys.sort).must_equal MOVIE_FIELDS
      end
    end

    it "will respond with an empty array when there are no movie" do
      # Arrange
      Movie.destroy_all

      # Act
      get movies_path

      # Assert
      body = check_response(expected_type: Array)
      expect(body).must_equal []
    end
  end


  describe "show" do
    it "retrieves one movie" do
      # Arrange
      movie = Movie.first

      # Act
      get movie_path(movie)
      body = JSON.parse(response.body)

      # Assert
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal MOVIE_FIELDS
    end

    it "sends back not found if the MOVIE does not exist" do
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

  describe 'create' do

    before do
      # Create valid request
      @movie = {
          title: "Xmen",
          overview: "Mutants",
          release_date:  "Fri, 05 Nov 2010",
          inventory: "25",
          available_inventory: "25"
      }
    end

    it 'responds with created status when request is good' do
  
      expect{post movies_path, params: @movie}.must_differ 'Movie.count', 1
      # check for created code
      must_respond_with :created
      # body contains new movie's id
      body = JSON.parse(response.body)
      expect(body.keys.sort).must_equal [ "available_inventory","id","inventory", "overview", "release_date","title" ]
    end

    it 'responds with bad_request when request has no title' do
      # make bad request
      no_title_movie = @movie
      no_title_movie[:title] = nil
      # call
      # verify count doesn't change
      expect{post movies_path, params: @movie}.wont_change 'Movie.count'
      # verify bad_request status
      must_respond_with :bad_request
      # body contains errors which contain string 'title'
      body = JSON.parse(response.body)
      expect(body['errors'].keys).must_include 'title'
    end

  end
end
