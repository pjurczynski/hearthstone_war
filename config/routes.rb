Rails.application.routes.draw do
  resources :decks, only: %w(index show)
  root to: 'visitors#index'
end
