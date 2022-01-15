require 'rails_helper'

RSpec.describe Users::SignIn do
  it 'sign in user' do
    user = create(:user)
    Users::SignIn.call(
      {
        email: user.email,
        password: user.password
      }
    )
  end

  it 'fails if entered wrong email or password' do
    user = create(:user)
    expect do
      Users::SignIn.call(
        {
          email: user.email,
          password: 'Qwerty12345'
        }
      )
    end
  end
end
