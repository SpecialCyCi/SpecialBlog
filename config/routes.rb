SpecialBlog::Application.routes.draw do
  resources :works

  devise_for :admins
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root 'articles#index'
  resources :articles do
    resources :comments, shallow: true
  end
end
