Rails.application.routes.draw do
  # Root for users who are signed in
  authenticated do
    root to: 'users#index'
  end

  ########################## D E V I S E  /  U S E R S #########################
  # User CRUD related routes
  resources :users do
    collection { get :search, to: 'users#index' }
  end

  # Customize devise sign-in/sign-out/sign-up urls and registrations controller
  devise_for :users, path: '',
                     path_names: { sign_in: 'sign_in',
                                   sign_out: 'sign_out', sign_up: 'sign_up' },
                     controllers: { registrations: 'registrations' }

  # Create 'sign_out_path' alias for devise/sessions#destroy
  devise_scope :user do
    get 'sign_out' => 'devise/sessions#destroy', as: :sign_out
  end

  # Custom user related routes
  get '/my_profile' => 'users#show', as: :my_profile

  ################################ R O L E S ##################################
  resources :roles do
    collection { get :search, to: 'roles#index' }
  end

  ################# U N A U T H E N T I C A T E D   U S E R S #################
  unauthenticated do
    root to: 'home#index', as: :welcome
    devise_scope :user do
      get 'sign_in' => 'devise/sessions#new', as: :sign_in
      get 'sign_up' => 'devise/sessions#create', as: :sign_up
    end
  end

  ################ P A R S L E Y   J S   V A L I D A T I O N S ###############
  get '/check_user_email_unique'     => 'users#check_email_unique'
  get '/check_user_password_match'   => 'users#check_password_match'
  get '/check_role_name_unique'      => 'roles#check_name_unique'

  # TO_REMOVE: This is for testing the application#routing_error method.
  # MiniTest throws UrlGenerationError instead of matching the route glob.
  get '/routing_error', via: :all, to: 'errors#routing_error'
  # Catch all route, keep at the end
  get '/*path', via: :all, to: 'errors#routing_error'
end
