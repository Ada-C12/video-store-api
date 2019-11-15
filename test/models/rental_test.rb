require "test_helper"

describe Rental do
  let (:rental1) { rentals(:rental1) }
  
  describe "validations" do
    it "requires a customer_id" do
      rental1.customer_id = nil
      
      expect(rental1.valid?).must_equal false
    end

    it "requires a movie_id" do
      rental1.movie_id = nil
      
      expect(rental1.valid?).must_equal false
    end
  end
end
