# frozen_string_literal: true

Rails.application.routes.draw do
  resources :albums, only: %i[index new create edit update destroy] do
    resources :tracks, only: %i[index new edit update destroy]
  end

  post 'publications/albums/:album_id', to: 'publications#create', as: 'publications'

  root to: 'albums#index'

  if Rails.env.development? || Rails.env.test?
    post 'session_without_csrf', to: 'sessions#create_without_csrf'
    delete 'session_without_csrf', to: 'sessions#destroy_without_csrf'
  end
end
