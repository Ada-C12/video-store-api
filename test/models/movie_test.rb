require "test_helper"

describe Movie do
  describe "validations" do
    let(:movie) {movies(:movie_one)}
    
    it "can be created" do
      expect(movie.valid?).must_equal true
    end
    
    it "requires title, inventory" do
      required_fields = [:title, :inventory]
      
      required_fields.each do |field|
        movie[field] = nil
        
        expect(movie.valid?).must_equal false
        
        movie.reload
      end
    end 
  end
end
