Rails.application.routes.draw do
  resources :decks, only: %w(index show)
  resources :games, only: %w(new create edit update)

  root to: 'games#new'
end
