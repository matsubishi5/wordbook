Rails.application.routes.draw do
  root 'homes#top'
  get 'users/ranking', to: 'users#ranking'

  resources :questions, except: %i(show) do
    collection do
      get :search
      get :learning
    end
  end
end
