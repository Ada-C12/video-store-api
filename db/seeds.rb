JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create!(
    {
      title: movie["title"],
      overview: movie["overview"],
      release_date: movie["release_date"],
      inventory: movie["inventory"],
      available_inventory: movie["inventory"]
      })
    end
    
    