Openfoodweb::Application.routes.draw do
  root :to => 'spree/home#index'

  resources :enterprises do
    get :suppliers, :on => :collection
    get :select_distributor, :on => :member
    get :deselect_distributor, :on => :collection
  end

  # Deprecated
  resources :suppliers
  # Deprecated
  resources :distributors do
    get :select, :on => :member
    get :deselect, :on => :collection
  end

  namespace :admin do
    resources :enterprises do
      post :bulk_update, :on => :collection, :as => :bulk_update
    end

    # Deprecated
    resources :distributors do
      post :bulk_update, :on => :collection, :as => :bulk_update
    end
    # Deprecated
    resources :suppliers
  end

  # Mount Spree's routes
  mount Spree::Core::Engine, :at => '/'
end


Spree::Core::Engine.routes.prepend do
  match '/admin/reports/orders_and_distributors' => 'admin/reports#orders_and_distributors', :as => "orders_and_distributors_admin_reports",  :via  => [:get, :post]
  match '/admin/reports/group_buys' => 'admin/reports#group_buys', :as => "group_buys_admin_reports",  :via  => [:get, :post]
end
