require "test_helper"

describe MoviesController do
  describe 'index' do
    it 'responds with json and success' do
      get movies_path
      
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it 'responds with an array of movie hashes' do
      get movies_path

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Array
      expect(body.count).must_equal Movie.count

      body.each do |movie|
        expect(movie).must_be_instance_of Hash
        expect(movie.keys.sort).must_equal ["id", "release_date", "title"]
      end
    end
  end

  describe "show" do
    it 'responds with json and success' do
      get movie_path(movies(:first))

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it 'responds with the correct movie hash' do
      get movie_path(movies(:second))

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
      expect(body["title"]).must_equal movies(:second).title
    end

    it 'responds with error when given incorrect parameter' do
      get movie_path(-1)

      body = JSON.parse(response.body)

      expect(body).must_be_instance_of Hash
      expect(body["errors"]["id"]).must_equal ["Movie with id -1 not found."]
    end
  end
end
