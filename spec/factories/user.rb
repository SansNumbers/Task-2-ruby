FactoryBot.define do
    factory :user do
      name { 'test_user' }
      email { 'test_user@gmail.com' }
      password  { "Qwerty12345" }
    end
  end
  