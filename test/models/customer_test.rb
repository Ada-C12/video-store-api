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
    before do
      Customer.destroy_all
      
      @customer_one = Customer.create(name: "b", postal_code: 00003)
      @customer_two = Customer.create(name: "a", postal_code: 00002)
      @customer_three = Customer.create(name: "c", postal_code: 00001)
    end
    
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
      
      it "if no type of sort is specified, customers are sorted by ID" do
        customers = Customer.group_by_n(nil, nil, nil)
        
        expect(customers[0].id < customers[1].id).must_equal true
        expect(customers[1].id < customers[2].id).must_equal true
      end
    end
    
    describe "self.sort_by_name" do
      it "sorts customers by name" do
        customers = Customer.sort_by_type("name")
        
        expect(customers[0].name < customers[1].name).must_equal true
        expect(customers[1].name < customers[2].name).must_equal true
      end
    end
    
    describe "self.sort_by_registered_at" do
      it "sorts customers by registration time" do
        @customer_one.update(registered_at: @customer_one.created_at)
        @customer_two.update(registered_at: @customer_two.created_at)
        @customer_three.update(registered_at: @customer_three.created_at)
        
        customers = Customer.sort_by_type("registered_at")
        
        expect(customers[0].registered_at < customers[1].registered_at).must_equal true
        expect(customers[1].registered_at < customers[2].registered_at).must_equal true
      end
    end
    
    describe "self.sort_by_postal_code" do
      it "sorts customers by postal code" do
        customers = Customer.sort_by_type("postal_code")
        
        expect(customers[0].postal_code < customers[1].postal_code).must_equal true
        expect(customers[1].postal_code < customers[2].postal_code).must_equal true
      end
    end
  end
  
end
