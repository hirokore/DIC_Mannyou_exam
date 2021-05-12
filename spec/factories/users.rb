FactoryBot.define do
  factory :user do
    name { "mob1" }
    email { "mob1@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    admin { false }
  end
  factory :second_user, class: User do
    name { "mob2" }
    email { "mob2@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    admin { false }
  end
  factory :root_user, class: User do
    name { "root" }
    email { "root@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    admin { true }
  end
end
