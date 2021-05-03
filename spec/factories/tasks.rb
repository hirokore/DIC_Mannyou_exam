FactoryBot.define do
  factory :task do
    name { 'test_first' }
    details { 'test_first' }
  end
  factory :second_task, class: Task do
    name { 'test_second' }
    details { 'test_second' }
  end
end
