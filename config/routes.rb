Rails.application.routes.draw do
 
  namespace :api do
    namespace :v1 do

      resources :users do
      	resources :decisions do
        	resources :items
      	end
      end
       post '/login', to: "users#login"
       get '/current_user', to: "users#current"
    end
  end
end


