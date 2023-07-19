require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'Get users#index' do
    it 'returns successful response' do
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'renders template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'displays template' do
      get users_path
      expect(response.body).to include('Welcome to index page')
    end
  end

  describe 'Get users#show' do
    let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

    it 'returns successful response' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end

    it 'renders template' do
      get '/users/1'
      expect(response).to render_template(:show)
    end

    it 'displays template' do
      get '/users/1'
      expect(response.body).to include('Welcome to show all users')
    end
  end
end
