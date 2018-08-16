# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
orders = [
	["cc x 1", "Yopapa", "91827582", 1],
	["bl x 1", "Yomama", "91827582", 1],
	["ss x 1", "DaWae", "91827582", 1],
	["ccd x 1", "Yolanda", "91827582", 2],
	["mr with egg x 1", "Anakin", "91827582", 2],
	["cs x 1", "Shakira", "91827582", 2]
]

orders.each do |description, name, number, user_id|
	Order.create(
		description: description, 
		name: name,
		number: number,
		user_id: user_id
	)
end