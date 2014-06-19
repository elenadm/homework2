Rails.application.routes.draw do
  root to: 'welcome#show'
  resources :movies do
    patch 'publication', on: :member
  end
end
