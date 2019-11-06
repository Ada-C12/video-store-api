require "test_helper"

describe MoviesController do
  before do
    @movie = {
      movie: {
        field: "field",
      }
    }
  end
  it 'responds with created status when request is good' do
    expect(post movies_path, params: @movie).must differ "Movie.count", 1
    must_respond_with :created
    body = JSON.parse(response.body)
    expect(body.keys).must_equal ['id']
  end

  it 'responds with bad_request when request has no field' do
    @movie[:movie][:field] = nil
    
    expect(post movies_path, params: @movie).wont_change 'Movie.count'
    must_respond_with :bad_request
    
    body = JSON.parse(response.body)
    expect(body['errors'].must_include 'field')
  end
end 
