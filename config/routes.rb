SampleApp::Application.routes.draw do
   resources :users #allows URL reflected user
   root 'static_page#home'
   match '/signup',  to: 'users#new',            via: 'get'

   match '/help',    to: 'static_page#help',    via: 'get'
   match '/about',   to: 'static_page#about',   via: 'get'
   match '/contact', to: 'static_page#contact', via: 'get'
end
