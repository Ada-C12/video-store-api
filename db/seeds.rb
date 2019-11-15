JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  customer = Customer.new(customer)
  customer.movies_checked_out_count = 0
  customer.save!
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  movie = Movie.new(movie)
  movie.available_inventory = movie.inventory
  movie.save!
end

JSON.parse(File.read('db/seeds/rentals.json')).each do |rental|
  Rental.create!(rental)
end
