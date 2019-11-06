require "test_helper"

describe RentalsController do
  describe "checkin" do
    let(:rental_data) {
      {
          title: 'Momento',
          overview: 'Mind Fuck',
          release_date: '2003-01-02',
          inventory: 20,
        }
    }
    it "responds with JSON and success when passed in valid params" do
      get movies_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end
  end
end
