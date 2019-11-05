require "test_helper"

describe Customer do
  describe "validations" do 
    before do
      @customers = Customer.all
      @customer = customers(:eminique)
    end

    it "can have the all customer fields" do
      @customers.each do |customer|
        [:name, :registered_at, :postal_code, :movies_checked_out_count, :city, :state, :address, :phone].each do |field|
          expect(customer).must_respond_to field
        end
      end
    end
    
    it 'must have a name' do
      @customer.name = nil

      refute(@customer.valid?)
      expect(@customer.errors.messages).must_include :name
      expect(@customer.errors.messages[:name]).must_include "can't be blank"
    end

    it 'must have a registered_at' do
      @customer.registered_at = nil

      refute(@customer.valid?)
      expect(@customer.errors.messages).must_include :registered_at
      expect(@customer.errors.messages[:registered_at]).must_include "can't be blank"
    end

    it 'must have a address' do
      @customer.address = nil

      refute(@customer.valid?)
      expect(@customer.errors.messages).must_include :address
      expect(@customer.errors.messages[:address]).must_include "can't be blank"
    end

    it 'must have a phone' do
      @customer.phone = nil

      refute(@customer.valid?)
      expect(@customer.errors.messages).must_include :phone
      expect(@customer.errors.messages[:phone]).must_include "can't be blank"
    end

  end
  
  describe "relationships" do
    before do
      @customer = customers(:eminique)
    end
    it "can have many rentals" do
      expect(@customer.rentals.count).must_equal 2
      @customer.rentals.each do |rental|
        expect(rental).must_be_instance_of Rental
      end
    end

    it "returns [] if no rentals for user" do
      customer = customers(:gretchen)
      
      expect(customer.rentals.count).must_equal 0
      expect(customer.rentals).must_equal []
    end
  end
end
