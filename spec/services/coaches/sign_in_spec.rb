require 'rails_helper'

RSpec.describe Coaches::SignIn do
  it 'sign in coach' do
    coach = create(:coach)
    Coaches::SignIn.call(
      {
        email: coach.email,
        password: coach.password
      }
    )
  end

  it 'fails if entered wrong email or password' do
    coach = create(:coach)
    expect do
      Coaches::SignIn.call(
        {
          email: coach.email,
          password: 'Qwerty12345'
        }
      )
    end
  end
end
