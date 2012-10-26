MongoBlog::Application.routes.draw do
  
  devise_for :users, 
  	:path => "",
  	:path_names => { :sign_in => 'login', :sign_out => 'logout' },
  	:controllers => { :sessions => :sessions },
  	:skip => [:passwords, :registrations]

  root :to => "home#index"

  namespace :cpanel do
  	root :to => "home#index"
  	resources :categories do
      get 'search', :on => :collection
      post 'destroies', :on => :collection
    end
    resources :posts do
      get 'search', :on => :collection
      post 'destroies', :on => :collection
    end
  end
  
  resources :categories
  resources :posts
end
