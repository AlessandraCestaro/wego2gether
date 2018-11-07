Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :trips do
  	resources :user_trips, only: [:show, :update] do 
      member do
      	get "declined"
      end 
  	end
  	resources :votes, only: [:new, :create]
  end

end
