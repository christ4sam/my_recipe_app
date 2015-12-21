Rails.application.routes.draw do
  
  root 'pages#home'
  
  get '/home', to: 'pages#home' # will go to the home page will use the page controller home action
 
 #get '/recipes', to: 'recipes#index' #will go to recipes page to list out all our recipes this is using recipe controller index action
 #get '/recipes/new', to: 'recipes#new', as: 'new_recipe' #will get the form needed to create new recipe use recipes controller new action
 # post '/recipes', to: 'recipes#create' #this will submit the form after filled to create a new recipe uses recipe controller create action
 #get '/recipes/:id/edit', to: 'recipes#edit', as: 'edit_recipe' #this will get the page for one recipe for editing recipe controller edit action
 #patch '/recipes/:id', to: 'recipes#update' #this will submit the recipe back after editing recipe controller update
 #get '/recipes/:id', to: 'recipes#show', as: 'recipe' #this will go to the page that shows one single recipe
 #get '/recipes/:id', to: 'recipes#destroy' #this displays a singel recipe to be destroyed
 

# when a user clicks on the likes icon abd the HTTP verb will be a post request for a like to a recipe
 resources :recipes do
   member do
     post 'like'
   end
      
  end
  
  resources :chefs, except: [:new, :destroy]
  get '/register', to: 'chefs#new'
  
  
  get '/login', to: "logins#new" #login -> new session
  post '/login', to: "logins#create" # logout -> create session
  get '/logout', to: "logins#destroy"  # post -> closs session
  
  resources :styles, only: [:new, :create, :show ]
  resources :ingredients, only: [:new, :create, :show ]
  
end
 
 
 


