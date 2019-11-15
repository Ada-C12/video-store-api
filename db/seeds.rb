JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end
puts "Customers created: #{Customer.count}"

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  Movie.create!(movie)
end
puts "Movies created: #{Movie.count}"