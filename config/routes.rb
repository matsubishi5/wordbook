Rails.application.routes.draw do
  root 'homes#top'

  resources :sessions, only: %i(new create destroy)

  resources :users, only: %i(new create) do
    collection do
      get :ranking
    end
  end

  resources :questions, except: %i(show) do
    collection do
      get :search
      get :learning
    end
  end
end
