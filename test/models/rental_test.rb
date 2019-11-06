require "test_helper"

describe Rental do
  describe 'relations' do
    it 'belongs to a movie' do
      expect(Rental.new).must_respond_to(:movie)
    end 

    it 'belongs to a customer' do
      expect(Rental.new).must_respond_to(:customer)
    end
  end
end
