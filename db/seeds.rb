# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "creating 10 group events..."

10.times do |i|
  GroupEvent.create({
    name: "block party ##{i}",
    description: "block party at my house",
    starts_at: "2016-11-08 18:00:00",
    ends_at: "2016-11-08 21:00:00",
    location: "my house, #{i} street, london",
    })
end
