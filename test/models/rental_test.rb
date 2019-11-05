require "test_helper"

describe Rental do
  let(:new_rental) {
    new_rental = Rental.new(
      checkout_date: Time.new(2018, 1, 1),
      due_date: Time.new(2018, 1, 7),
      movie: movies(),
      customer: customers(:customer1),
    )
  }

  describe "instantiation" do
    it "can instantiate a valid rental" do
    end
  end
  

end
