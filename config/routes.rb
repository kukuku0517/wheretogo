Rails.application.routes.draw do
  
  get 'register/info1'

  get 'register/info2'
  
  post 'register/infoget' =>'register#infoget',as: :register_infoget

  get 'visitor/main'

  root 'room#index'
  
  get 'room/index' => 'room#index',as: :index

  get 'room/create'=> 'room#create',as: :create

  get 'room/show/:id'=> 'room#show',as: :show
  get 'room/find/:id'=> 'room#find',as: :find
  get 'room/destroy_member/:id' => 'room#destroy_member',as: :destroy_member
  get 'room/destroy_self/:id' => 'room#destroy_self',as: :destroy_self
  post 'room/save/:id' => 'room#save',as: :save
  
  get 'room/result/:id'=> 'room#result'
  post 'room/result/:id'=> 'room#result',as: :result
  get 'room/result2/:id'=> 'room#result2',as: :result2
 
  post 'room/find_temp/:id'=> 'room#find_temp',as: :find_temp
  post 'room/refresh' => 'room#refresh',as: :refresh
  
   get 'room/prac' => 'room#prac'
   
  get 'room/like_create' => 'room#like_create',as: :like_create
  get 'room/like/:id' => 'room#like',as: :like
  get 'room/like_result/:id' => 'room#like_result',as: :like_result


get 'room/find_route/:id' => 'room#find_route',as: :find_route
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
