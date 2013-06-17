namespace :db do

  desc "Fill database with sample data"

  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end
def make_users
  admin = User.create!(name: "Sam Clam",

                       email: "sam@mars.org",

                       password: "foodbar",

                       password_confirmation: "foodbar")

  admin.toggle!(:admin)

  99.times do |n|

    name  = Faker::Name.name

    email = "robot-#{n+1}@mars.org"

    password  = "password"

    User.create!(name: name,

                 email: email,

                 password: password,

                 password_confirmation: password)

  end
end
def make_microposts

  users = User.all(limit: 6)

  50.times do

    content  = Faker::Lorem.sentence(5)

    users.each { |u| u.microposts.create!(content: content)}

  end
end
def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |f| user.follow!(f) }
  followers.each      { |f| f.follow!(user) }

end
