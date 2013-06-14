namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Sam Clam",
                         email: "sam@mars.org",
                         password: "foodbar",
                         password_confirmation: "foodbar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "sam-#{n+1}@mars.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      content  = Faker::Lorem.sentence(5)
      users.each { |u| u.microposts.create!(content: content)}
    end
  end
end
