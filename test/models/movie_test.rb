require "test_helper"

describe Movie do
  describe 'validations' do
    before do
      @movie = Movie.new(title: "titanic", overview: "long", release_date: "1990-03-20", inventory: 10) 
    end
    
    it 'can make a movie with a title' do
      assert @movie.valid?
    end

    it 'wont make a movie without a title' do
      @movie[:title] = nil
      refute @movie.valid?
    end
    
    it 'can make a movie with a overview' do
      assert @movie.valid?
    end

    it 'wont make a movie without a overview' do
      @movie[:overview] = nil
      refute @movie.valid?
    end
    
    it 'can make a movie with a release_date' do
      assert @movie.valid?
    end

    it 'wont make a movie without a release_date' do
      @movie[:release_date] = nil
      refute @movie.valid?     
    end
    
    it 'can make a movie with a inventory' do
      assert @movie.valid?
    end

    it 'wont make a movie without a inventory' do
      @movie[:inventory] = nil
      refute @movie.valid?     
    end
    
    it 'wont make a movie with a non-numeric inventory' do
      @movie[:inventory] = "x"
      refute @movie.valid?          
    end
  end
end
