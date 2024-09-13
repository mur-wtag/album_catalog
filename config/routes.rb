# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :users, controller: "clearance/users", only: %i[create]
  resources :albums, only: %i[index new create edit update destroy] do
    resources :tracks, only: %i[index new edit update destroy]
  end

  root to: 'albums#index'
end
