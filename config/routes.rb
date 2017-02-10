Rails.application.routes.draw do


  devise_for :users
  # get 'flight/details'


  root :to => 'flight#index', :via => :get
  match 'flight/:name' => 'flight#details', :as => :flight_detail, :via => :get

     get 'ajaxt/:name1/:id1', to: 'ajaxt#all'
     get 'ajaxt/:name0', to: 'ajaxt#low'
     get 'ajaxt/header/banner/0', to: 'ajaxt#header'
     post 'usermsg', to: 'ajaxt#usermsg'

     get 'backga/:c1/:c2/:c3/:c4', to: 'background#backga'
     get 'backgau/:c1/:c2/:c3', to: 'background#backgau'
     get 'backgas/:c1/:c2/:c3', to: 'background#backgas', as: 'backgview'
     get 'backglist/:c1/:c2', to: 'flight#backglist'


     get 'user/profile/:id', to: 'user#profile', as: 'uprofile'
     get 'uflight/:c1/:c2/:c3', to: 'user#udetails', as: 'udetails'

     get 'services', to: 'flight#services', as: 'services'
     get 'about', to: 'flight#about', as: 'about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
