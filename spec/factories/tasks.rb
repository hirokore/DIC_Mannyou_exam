FactoryBot.define do
  factory :task do
    name { 'test_first' }
    details { 'test_first' }
    expired_at { '2021-05-10' }
  end
  factory :second_task, class: Task do
    name { 'test_second' }
    details { 'test_second' }
    expired_at { '2021-05-05' }
  end
end
