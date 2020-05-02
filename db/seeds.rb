50.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  profile = Faker::Games::Fallout
  image = File.open(%q(./app/assets/images/no_image.png))
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               text: profile,
               text: image,
               )
end
