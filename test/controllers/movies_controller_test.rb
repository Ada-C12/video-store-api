require "test_helper"

describe MoviesController do
  describe "create" do
    before do
      @movie = {
        movie: {
          title: "Terminator: Dark Fate",
          overview: "Daniela's life changes when she finds out a Terminator is after her.",
          release_date: "2019-11-01",
          inventory: 5
        }
      }
    end

    it "responds with created status when request is good" do
      expect{post movies_path, params: @movie}.must_differ "Movie.count", 1

      must_respond_with :created
      body = JSON.parse(response.body)
      expect(body.keys).must_equal ['id']
      # compare to newly created movie
      new_movie = Movie.last
      p new_movie
      expect(new_movie.title).must_equal @movie[:movie][:title]
      expect(new_movie.overview).must_equal @movie[:movie][:overview]
      expect(new_movie.release_date).must_equal @movie[:movie][:release_date]
      expect(new_movie.inventory).must_equal @movie[:movie][:inventory]
    end

    it "responds with bad_request when request has invalid release_date" do
      # make bad request
      invalid_movie = @movie
      # I added release date validation on a different branch
      invalid_movie[:movie][:release_date] = "HOOBASTANK"
      p invalid_movie
      # call
      # verify count doesn't change
      expect{post movies_path, params: invalid_movie}.wont_change 'Movie.count'
      # verify bad_request status
      must_respond_with :bad_request
      # body contains errors which contain string 'name'
      body = JSON.parse(response.body)
      expect(body['errors']).must_include # release_date
    end
  end
end
