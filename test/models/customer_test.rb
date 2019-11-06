require "test_helper"

describe Customer do
  
  describe "relationships" do
    it "can have many rentals" do
      movie = Movie.create(title: "valid movie", inventory: 10)
      customer = Customer.create(name: "valid customer")
      rental = Rental.create(movie_id: movie.id, customer_id: customer.id)
      
      expect(customer).must_respond_to :rentals
      customer.rentals.each do |rental|
        expect(rental).must_be_kind_of Rental
      end
      expect(customer.rentals.length).must_equal 1
    end
  end

  describe "custom methods" do
    let(:customer_one) { Customer.create(name: "b") }
    let(:customer_two) { Customer.create(name: "a") }
    let(:customer_three) { Customer.create(name: "c") }

    describe "self.sort_by_group" do
      it "returns an array of customers if n is defined but p is not defined" do
        group = Customer.group_by_n(nil, nil, nil)

        expect(group.length).must_equal 3
      end

      it "returns an array of customers for that page if n and p are defined" do
        group = Customer.group_by_n("name", 2, 2)
        
        expect(group.length).must_equal 1

        group = Customer.group_by_n("name", 2, 1)
        
        expect(group.length).must_equal 2
      end
    end

    describe "self.sort_by_name" do
      it "sorts customers by name" do
        customers = Customer.sort_by_name
        
        expect(customers[0].name < customers[1].name).must_equal true
        expect(customers[1].name < customers[2].name).must_equal true
      end
    end
  end
  
end
