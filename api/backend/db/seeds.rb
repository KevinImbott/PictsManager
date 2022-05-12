# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


u1 = User.create(pseudo: "test", email: "test@test.com", password: "password")
u2 = User.create(pseudo: "test2", email: "test2@test2.com", password: "password")
p1 = Picture.create(name: "First Picture", description: "This is my first Picture #seed")
p2 = Picture.create(name: "Second Picture", description: "This is my second Picture #seed")
a1 = Album.create(name: "First Album", users: [u1, u2], pictures: [p1, p2])