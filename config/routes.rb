# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  
  mount BaseAPI, at: BaseAPI::PREFIX

  # Admin authentication
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure', :as => :failure
  match '/auth/:provider/callback' => 'sessions#create', via: %i[get post]
end
