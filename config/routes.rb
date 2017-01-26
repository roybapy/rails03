Rails.application.routes.draw do


  # get 'flight/details'


  root :to => 'flight#index', :via => :get
  match 'flight/:name' => 'flight#details', :as => :flight_detail, :via => :get

     get 'ajaxt/:name1/:id1', to: 'ajaxt#all'
     get 'ajaxt/:name0', to: 'ajaxt#low'
     get 'ajaxt/header/banner/0', to: 'ajaxt#header'

     get 'backga/:c1/:c2/:c3', to: 'background#backga'
     get 'backgau/:c1/:c2/:c3', to: 'background#backgau'
     get 'backgas/:c1/:c2/:c3', to: 'background#backgas', as: 'backgview'
     get 'backglist/:c1/:c2', to: 'flight#backglist'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
