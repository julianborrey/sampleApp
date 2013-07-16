SampleApp::Application.routes.draw do
   root 'static_page#home'

   match '/help',    to: 'static_page#help',    via: 'get'
   match '/about',   to: 'static_page#about',   via: 'get'
   match '/contact', to: 'static_page#contact', via: 'get'
end
