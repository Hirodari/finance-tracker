Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'my_portfolio', to:'users#my_portofolio'
  get 'search_stock', to:'stocks#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
