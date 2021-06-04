require "date"
require "json"

def time_price(start_date, end_date, price_per_day)
  # +1 meaning that the start date are included
  (Date.parse(end_date) - Date.parse(start_date) + 1).to_i * price_per_day
end

def find_car(cars, id)
  cars.find { |car| car["id"] == id }
end

input = File.read('./data/input.json')
data_hash = JSON.parse(input)

cars = data_hash["cars"]
rentals = data_hash["rentals"]

data_hash = {}
rentals_hash = []

rentals.each do |rental|
  car = find_car(cars, rental["car_id"])
  time_price = time_price(rental["start_date"], rental["end_date"], car["price_per_day"] )
  total = time_price + (rental["distance"] * car["price_per_km"])

  rentals_hash << { "id" => rental["id"], "price" => total }
end

data_hash["rentals"] = rentals_hash

File.open("output.json", "w") do |f|
  f.write(JSON.pretty_generate(data_hash))
end

