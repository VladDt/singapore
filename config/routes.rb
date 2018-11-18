Rails.application.routes.draw do

  namespace 'api' do

    namespace :v1 do

      scope(path_names: { new: '', create: '' }) do
        resources :users, only: [:new, :create], path: 'signup'
      end

      scope(path_names: { new: '', create: '' }) do
        resources :sessions, only: [:new, :create], path: 'login'
      end


      resources :users, only: [:index, :show, :edit, :update]
      post '/users/:id', to: 'users#destroy'
      
      #get '/activate_account', to: 'users#activate_account'

      delete '/logout', to: 'sessions#destroy'

      get '/accept_doctor_approval', to: 'users#accept_doctor_approval'
      get '/deny_doctor_approval', to: 'users#deny_doctor_approval'

      resources :visits, only: [:index, :create, :update, :destroy]

      root 'users#show'

    end

  end

end
