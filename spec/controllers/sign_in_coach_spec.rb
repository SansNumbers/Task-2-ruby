require 'rails_helper'

RSpec.describe SignInCoachController, type: :controller do
  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'returns a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
