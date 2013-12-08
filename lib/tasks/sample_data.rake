namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all # pull all user instances and set to users
  user  = users.first # set user to first user from users array
  followed_users = users[2..50] # set followed_users to users 2-50
  followers      = users[3..40] # set followers to users 3-40
  # for each followed_user, follow the followed user
  followed_users.each { |followed| user.follow!(followed) }
  # for each follower, set follower to follow user
  followers.each      { |follower| follower.follow!(user) }
end
