Rails.application.routes.draw do

  namespace :api do
    resources :characters do
      get 'appearance'
      get 'traits'
      get 'relationships'
    end
  end

  resources :characters

  root 'characters#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end