require "test_helper"

describe Customer do
  before do
    @valid_customer = customers(:customer1)
  end

  describe "validation" do
    it "is avlid when all fields are present" do
      result = @valid_customer.valid?

      expect(result).must_equal true
    end

    it "is invalid without a name" do
      @valid_customer.name = nil
      result = @valid_customer.valid?

      expect(result).must_equal false
    end

    it "is invalid with a duplicate name" do
      @valid_customer.name = customers(:customer2).name
      result = @valid_customer.valid?

      expect(result).must_equal false
    end 

    it "is invalid without a registered date" do
      @valid_customer.registered_at = nil
      result = @valid_customer.valid?

      expect(result).must_equal false
    end

    it "is invalid without a postal code" do
      @valid_customer.postal_code = nil
      result = @valid_customer.valid?

      expect(result).must_equal false
    end

    it "is invalid without a phone number" do
      @valid_customer.phone = nil
      result = @valid_customer.valid?
      
      expect(result).must_equal false
    end
  end

  describe "relationship" do
    before do 
      @rental = Rental.new(
        checkout_date: Date.today,
        due_date: Date.today + 7,
        movie_id: movies(:movie2).id,
        customer_id: @valid_customer.id
      )
    end

    it "can have many movies through rental" do
      @rental.save

      customer = Customer.find_by(id: @valid_customer.id)

      expect(customer.movies.count).must_be :>=, 0
      expect(customer.movies).must_include movies(:movie2)
    end 
  end
end
