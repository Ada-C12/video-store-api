require "test_helper"

describe MoviesController do
  MOVIE_FIELDS = %w(id inventory overview release_date title)

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end 

  describe "index" do 
    it "responds with JSON and success" do 
      gets movies_path
      check_response(expected_type: Array)
    end

    it "responds with an array of movie hashes" do 
      get movies_path
      body = check_response(expected_type: Array)

      body.each do |movie|
        expect(movie.keys.sort).must_equal MOVIE_FIELDS
      end 
    end 

    # it "will respond with an empty array when there are no movies" do 
    #   Movie.destroy_all

    #   get movies_path

    #   body = check_response(expected_type: Array)
    #   expect(body).must_equal []
    # end 
  end 
end
