FactoryBot.define do
    factory :coach do
      name { 'test_coach' }
      email { 'test_coach@gmail.com' }
      password  { "Qwerty12345" }
    end
  end
  