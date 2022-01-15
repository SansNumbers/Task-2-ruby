require 'rails_helper'

RSpec.describe LandingPageController, type: :controller do
  describe 'GET #index' do
    it 'render template index [landing page]' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
