JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create!(movie)
end

Rental.create(customer_id: Customer.first.id, movie_id: Movie.first.id, checkout_date: Time.now, due_date: (Time.now + 5))