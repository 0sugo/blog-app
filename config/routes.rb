Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'devise/sessions'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[new create destroy]
      resource :like, only: :create
    end
  end
  delete '/users/:user_id/posts/:post_id/comments/:id', to: 'comments#destroy', as: :destroy_user_post_comment
end
