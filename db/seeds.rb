10.times do |n|
  name = "hiro#{n}"
  email = "hiro#{n}@dic.com"
  password = "000000"
  User.create!(name: name,email: email,password_digest: password)
end