Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'index#index'
  get 'search', to: 'index#results'
  get 'timeline', to: 'index#timeline'
  resources :index

  resources :sessions do
    collection do
      get :login, to: "sessions#new"
      post :login,  to: 'sessions#create'
      delete :logout,  to: 'sessions#destroy'
      get :signup, to: 'sessions#sign'
      post :save, to: 'sessions#save'
    end
  end

  resources :comments
end
