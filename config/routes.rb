SampleApp::Application.routes.draw do
   resources :user #allows URL reflected user
   root 'static_page#home'
   match '/signup',  to: 'user#new',            via: 'get'

   match '/help',    to: 'static_page#help',    via: 'get'
   match '/about',   to: 'static_page#about',   via: 'get'
   match '/contact', to: 'static_page#contact', via: 'get'
end
