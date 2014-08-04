Rebuttal::Application.routes.draw do

  root :to => 'blog#index'
  get 'new(/:id)', :controller=>:blog, :action=>:new
  post "save",:controller=>:blog,:action=>:save
  post "view_next",:controller=>:blog
  post "view_prev",:controller=>:blog
  post "starter",:controller=>:blog
  get "logout", :controller=>:auth
  get "rebuttal(/:id)", :controller=>:blog, :action=>:conversation
  
  
  # OAUTH (SOCIAL) OAUTH (SOCIAL) OAUTH (SOCIAL) OAUTH (SOCIAL) 
  get 'auth/:provider/callback', :to => 'auth#oauth'
  post 'auth/failure', :to => 'auth#oauth_fail'
  
  post 'auth(/:action(/:id))', :controller=>:auth, :id => /[^\/]*/
  
end
