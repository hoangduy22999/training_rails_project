Rails.application.routes.draw do
  devise_for :users

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  get '/exam-group/(:format)', to: 'exams#group'
  get '/exam/create', to: 'exams#new'
  post '/exam/create', to: 'exams#create'

  get '/question/create', to: 'questions#new'
  post '/question/create', to: 'questions#create'

  as :user do
    get "signin" => "devise/sessions#new"
    post "signin" => "devise/sessions#create"
    delete "signout" => "devise/sessions#destroy"
    get "signup" => "devise/"
  end

  # get "*path" => redirect("/")
end
