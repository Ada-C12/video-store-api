require "test_helper"
describe Movie do
    let(:create_movie){
        create_movie = Movie.new(
            title: "Daylight",
            overview: "must watch",
            release_date: Time.new(2019, 2, 6),
            inventory: 6
        )
    }

    describe "validations" do
        it "must have a title and inventory" do
            create_movie.title = nil
            _(create_movie.valid?).must_equal false
            _(create_movie.errors.messages).must_include :title
            _(create_movie.errors.messages[:title]).must_include "can't be blank"
        end

        it "inventory can not be blank" do
        create_movie.inventory = nil
        _(create_movie.valid?).must_equal false
        _(create_movie.errors.messages).must_include :inventory
        _(create_movie.errors.messages[:inventory]).must_include "can't be blank"
        end
    end

    describe "relations" do

        it "movie can have many rentals" do
            current_movie = movies(:swamp)
            expect(current_movie.rentals.count).must_equal 1
            current_movie.rentals.each do |rental|
                _(rental).must_be_kind_of Rental
            end
        end

        it "rentals can have a customer" do
            current_customer = customers(:one)
            expect(current_customer.rentals.count).must_equal 1
            current_customer.rentals.each do |rental|
                _(rental).must_be_kind_of Rental
            end
        end
    end

end
  
