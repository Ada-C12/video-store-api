require "test_helper"

describe Customer do
  describe 'relations' do
    it 'has many rentals' do
      customer = customers(:shelley)

      expect(customer).must_respond_to(:rentals)
    end 
  end
end
