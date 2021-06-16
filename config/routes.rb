Rails.application.routes.draw do
  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get 'profile', to: 'static_pages#profile'

  resources :exams do 
    collection do
      get :random
      post :random, to: 'exams#create_random'
      get :find_question, to: 'questions#find_question'
      get :search
    end

    member do
      get :submit
      post :sunmit, to: 'results#create'
    end
  end

  resources :questions do
  end
  
  resources :results, only: [:show, :create, :destroy] do
    collection do
      get :mysubmitted
      get :top
    end
  end

  devise_for :users
  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
    get "signup" => "devise/"
  end

  get '/users', to: 'users#show_all'
  delete '/users/:id/delete', to: 'users#destroy'

  # get "*path" => redirect("/")
end
