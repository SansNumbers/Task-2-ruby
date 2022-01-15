require 'rails_helper'

RSpec.describe Users::SignUp do
  it 'sign up user' do
    result = Users::SignUp.call(
      {
        name: 'Igor', email: 'example@gmail.com', password: 'Qwerty12345', password_confirmation: 'Qwerty12345'
      }
    )
    
    expect(User.count).to eq(1)

    expect(result.name).to eq('Igor')
    
    expect(result.email).to eq('example@gmail.com')
  end
end
