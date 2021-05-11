5.times do |n|
  name = "hiro#{n}"
  email = "hiro#{n}@dic.com"
  password = "000000"
  User.create!(name: name,email: email,password: password, password_confirmation: password)
end

from = Time.parse("2021/05/25")
to = Time.parse("2024/05/25")

10.times do |n|
  name = "hiro#{n}_task"
  details = "hiro#{n}_details"
  date = Random.rand(from..to)
  expired_at = date
  status = rand(1..3)
  priority = rand(1..3)
  user_id = rand(1..5)
  Task.create!(name: name, details: details, expired_at: date, status: status, priority: priority, user_id: user_id)
end
