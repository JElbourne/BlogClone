Rails.application.routes.draw do
  resources :posts
  devise_for :users
  
  mount StripeEvent::Engine, at: '/stripe/hook'
  if Rails.env.production?
    constraints(:host => /herokuapp.com/) do
      resource :subscription
    end
  else
    resource :subscription
  end
  resource :card
  get '/subscription/new', to: redirect('https://enter_your_app_name.herokuapp.com/subscription/new')
  get '/subscription/edit', to: redirect('https://enter_your_app_name.herokuapp.com/subscription/edit')
  
  
  get "/search", to: "search#index", as: "search" 
  
  root to: 'posts#index'

end
