FactoryBot.define do
  factory :task do
    name { 'test_first' }
    details { 'test_first' }
    expired_at { "(002020-04-01).to_date" } 
  end
  factory :second_task, class: Task do
    name { 'test_second' }
    details { 'test_second' }
    expired_at { "(002020-04-05).to_date" } 
  end
end
