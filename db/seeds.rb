User.create!(name:  "ラベル管理者",
  email: "root@dic.com",
  password:  "000000",
  password_confirmation: "000000",
  admin: true)

labels = ["C", "C+", "C++", "C#", "PHP", "Java", "Python", "Swift", "Ruby", "開発", "運用保守", "出向", "会議", "定時案件", "炎上案件", "営業", "受託"]

labels.each do |n|
  Label.create!(name: n, user_id: 1)
end

10.times do |n|
  name = "hiro#{n}"
  email = "hiro#{n}@dic.com"
  password = "000000"
  User.create!(name: name,email: email,password: password, password_confirmation: password)
end

from = Time.parse("2021/05/25")
to = Time.parse("2024/05/25")

150.times do |n|
  name = "hiro#{n}_task"
  details = "hiro#{n}_details"
  date = Random.rand(from..to)
  expired_at = date
  status = rand(1..3)
  priority = rand(1..3)
  user_id = rand(1..11)
  label_id = rand(1..16)
  Task.create!(name: name, details: details, expired_at: date, status: status, priority: priority, user_id: user_id, label_ids: [label_id])
end

