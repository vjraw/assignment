Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :customers, only: [:index, :show]
end
