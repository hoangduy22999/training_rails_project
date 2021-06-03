Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/exam/submit', to: 'exams#submit'
  get '/exams', to: 'exams#new'
  post '/exams', to: 'exams#create'
  get '/exams/show', to: 'exams#show'
  get '/exams/search', to: 'exams#search'
  get '/exam/detail', to: 'exams#detail'
  post '/exam/detail', to: 'results#create'
  get '/exam/random', to: 'exams#random'
  post '/exam/random', to: 'exams#create_random'
  get 'exam/find_question', to: 'questions#find_question'
  get '/exam', to: 'exams#edit'
  patch '/exam', to: 'exams#update'
  post 'exam/delete', to: 'exams#destroy'

  get '/question/create', to: 'questions#new'
  post '/question/create', to: 'questions#create'
  get '/question/search', to: 'questions#index'
  get '/question', to: 'questions#show'
  patch '/question', to: 'questions#update'
  post 'question/delete', to: 'questions#destroy' 
  resource :questions
  get '/results', to: 'results#show'
  post '/results', to: 'results#create'
  get '/results/detail', to: 'results#detail'
  get '/mysubmitted', to: 'results#mysubmitted'
  get '/results/top', to: 'results#top'

  get '/answer', to: 'questions#update'
  get 'profile', to: 'static_pages#profile'

  
  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
    get "signup" => "devise/"
  end

  get '/users', to: 'users#show_all'
  post '/users/delete', to: 'users#destroy'

  # get "*path" => redirect("/")
end
