# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :characters do
      resources :relationships, only: %i[create destroy]

      get 'appearance'
      get 'traits'
      get 'relationships'
    end
  end

  root 'characters#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
