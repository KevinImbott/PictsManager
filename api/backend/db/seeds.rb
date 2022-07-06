# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = User.create(pseudo: "Admin", email: "admin@admin.com", password: 'password')
10.times do |index|
    name = Faker::JapaneseMedia::OnePiece.unique.character
    u = User.create(pseudo: name, email: Faker::Internet.email(name: name), password: 'password')
    Faker::Number.between(from: 1, to: 3).times do
      a = Album.create(name: "Album de #{name}")
      a.owner = u
      a.users = [u, admin]
      Faker::Number.between(from: 1, to: 15).times do
          picture_name = Faker::Creature::Cat.name
          p = Picture.create(name: picture_name, tags: ["seed"])
          p.owner = u
          p.users = [u]
          sleep(1)
          # file = Down.download(Faker::LoremFlickr.image)
          p.img.attach(io: File.open(Down.download('https://source.unsplash.com/random/200x200')), filename: picture_name)
          # p.img.attach(io: File.open("./public/image.jpeg"), filename: picture_name)
          p.save
          a.pictures.push(p)
          a.save
      end
    end
end