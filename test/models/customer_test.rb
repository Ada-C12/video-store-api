require "test_helper"

describe Customer do
  describe "relations" do
    let(:customer) { customers(:shelley) }
    let(:rental_1)  {movies()}
    let(:rental_2)  {movies()}
    
    it "can have many rentals" do
      customer.rental << 
    end
    
    it "can have zero rentals" do
    end
  end
  
  describe "validations" do
    it "is valid when all fields are present" do
    end
    
    it 
  end
end
