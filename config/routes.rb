Kiwitime::Application.routes.draw do

  resources :sprints

  devise_scope :user do
    get 'users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  get "/p/:project_id/tasks" => redirect("/p/%{project_id}")
  get "/p/:project_id/tasks/:task_id/sittings" => redirect("/p/%{project_id}/tasks/%{task_id}")

  resources :users, path: 'u' do
    get 'page/:page' => :index, on: :collection
  end

  #resources :sessions, only: [:new, :create, :destroy]

  #match '/signin', to: 'sessions#new'
  #match '/signout', to: 'sessions#destroy'
  #match '/signup', to: 'users#new'


  resources :projects, path: 'p' do
    resources :tasks do
      post :sort, on: :collection
      resources :sittings
      member do
        get 'finish'
        get 'reopen'
        get 'start'
        get 'stop'
        get 'up'
        get 'accept'
      end
    end

    member do
      get 'report'
    end
  end


  authenticated do
    root to: "projects#index"
  end

  devise_scope :user do
    root :to => "pages#home"
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
