Rails.application.routes.draw do
  resources :messages, only: [:new, :create]
  resources :conversations, only: [:show, :index]
  
  devise_for :users 
  root 'dresses#index'

  resources :users, only: [:showroom, ]do
    resources :reviews, module: :users
  end

  get 'user/showroom', to: 'users#showroom', as: 'user'
  get '/profile', to: 'users#profile', as: 'profile'

  resources :dresses do 
    resources :reviews, module: :dresses
  end

  get '/filtered_result', to: 'dresses#filtered_result', as: 'filtered_result'
  #routing to about and contact page
  get '/about', to: 'pages#about', as: 'about_us'
  get '/contact', to: 'pages#contact', as: 'contact_us'

  #GET '/search'
  get '/search' => 'pages#search', :as => 'search_page'

  #routing of transactions
  resources :transactions, only: [:create, :show]
  get 'checkout/success', to: 'transactions#success', as: 'checkout_successful'
  get 'checkout/cancel', to: 'transactions#cancel', as: 'checkout_canceled'
  get 'purchases', to: 'transactions#purchases', as: 'purchases'
  get 'sales', to: 'transactions#sales', as: 'sales'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
