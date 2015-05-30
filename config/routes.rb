# == Route Map
#
#       Prefix Verb   URI Pattern                  Controller#Action
#  session_new GET    /session/new(.:format)       session#new
#         root GET    /                            pages#home
#   edit_users GET    /users/edit(.:format)        users#edit
#        users GET    /users(.:format)             users#index
#              POST   /users(.:format)             users#create
#     new_user GET    /users/new(.:format)         users#new
#         user PATCH  /users/:id(.:format)         users#update
#              PUT    /users/:id(.:format)         users#update
#              DELETE /users/:id(.:format)         users#destroy
#     monsters GET    /monsters(.:format)          monsters#index
#              POST   /monsters(.:format)          monsters#create
#  new_monster GET    /monsters/new(.:format)      monsters#new
# edit_monster GET    /monsters/:id/edit(.:format) monsters#edit
#      monster GET    /monsters/:id(.:format)      monsters#show
#              PATCH  /monsters/:id(.:format)      monsters#update
#              PUT    /monsters/:id(.:format)      monsters#update
#              DELETE /monsters/:id(.:format)      monsters#destroy
#       spells GET    /spells(.:format)            spells#index
#              POST   /spells(.:format)            spells#create
#    new_spell GET    /spells/new(.:format)        spells#new
#   edit_spell GET    /spells/:id/edit(.:format)   spells#edit
#        spell GET    /spells/:id(.:format)        spells#show
#              PATCH  /spells/:id(.:format)        spells#update
#              PUT    /spells/:id(.:format)        spells#update
#              DELETE /spells/:id(.:format)        spells#destroy
#        zones GET    /zones(.:format)             zones#index
#              POST   /zones(.:format)             zones#create
#     new_zone GET    /zones/new(.:format)         zones#new
#    edit_zone GET    /zones/:id/edit(.:format)    zones#edit
#         zone GET    /zones/:id(.:format)         zones#show
#              PATCH  /zones/:id(.:format)         zones#update
#              PUT    /zones/:id(.:format)         zones#update
#              DELETE /zones/:id(.:format)         zones#destroy
#        login GET    /login(.:format)             session#new
#              POST   /login(.:format)             session#create
#              DELETE /login(.:format)             session#destroy
#

Rails.application.routes.draw do


 get 'session/new'

 root :to => 'pages#home'

   resources :users, :except => [:edit, :show] do   #rerouting for edit profile
    collection do
      get '/edit' => 'users#edit'
    end
  end

  resources :monsters, :spells, :zones

  get '/login' => 'session#new'
  post '/login' => 'session#create'
  delete '/login' => 'session#destroy'


end
