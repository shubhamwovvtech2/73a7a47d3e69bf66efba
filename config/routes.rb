Rails.application.routes.draw do
  resources :follows
  resources :homes
  resources :tweets
  devise_for :users
  

  get '/usersfollow_list' => "follows#usersfollow_list"  

  post '/followuser' => "follows#followuser"
  post '/unfollowuser' => "follows#unfollowuser"    

  # root "homes#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
