Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Rails.application.routes.draw do
    root 'notes#home'

    # Route for user to signup
    get '/signup', to: 'users#new'

    # Creating nested routes since users can only access notes that belong to them.
    resources :users, only: [:new, :create] do
      resources :notes, only: [:new, :create, :edit, :show, :index]
    end

    # Routes for users to login and logout
    get    '/login',   to: 'sessions#new'
    post   '/login',   to: 'sessions#create'
    delete '/logout',  to: 'sessions#destroy'
end
