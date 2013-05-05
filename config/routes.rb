
OauthAjaxDemo::Application.routes.draw do
  root to: 'welcome#index'

  # omniauth routes
  # we handle failure the same way, just closing the auth window
  # and forcing js to fetch the user and get 401 error
  # You might setup your own action to display user the error
  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: 'sessions#create'

  # logout current user
  match 'signout', to: 'sessions#destroy', as: 'signout'

  # get current user json or 401 if unauthorized
  match 'me', to: 'sessions#show', as: 'me'
end
