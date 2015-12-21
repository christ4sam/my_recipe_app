class RecipesController < ApplicationController
  
  before_action :set_recipe, only: [:edit, :update, :show, :like]
   #here users that are NOT logged in can browse only the index (list recipe page)and the show recipe page
  before_action :require_user, except: [:show, :index, :like]
  #here for a user to like a recipe user must log in
  before_action :require_user_like, only: [:like]
  # Here we want to make sure sure that chef can only edit the reicpes they create them self
  # here we want this require_same_user method befor_action to be executed or run first before 
  # edit and update actions to verify that the current logged in user owns the recipe they want to edit or update
  # and that this actions can not be done through the browser as well
  before_action :require_same_user, only: [:edit, :update]
  
 
  
  
  #here we are paginating the recipe listing index page 
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
 
  end
  
  
  def show 
    #@recipe = Recipe.find(params[:id])
    
  end
  
  def new
    
    @recipe = Recipe.new
  end
  # here create a new recipe and save, if you are able to save you will be redirected to list and a 
  # flash message that recipe was created 
  # of recipes but if cant save the create a new form again will vghwbe displayed again.
  # with a chef object to ensure every recipe is created by a registered chef so each 
  # recipe created is assigned to a chef
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user #must log in to be able to create a recipe
    
      if @recipe.save
        flash[:success] = "Your recipe was created successfully!"
        redirect_to recipes_path
    else
      render :new
      end
    
  end
  #  to this point
  
  
  
  # here we are retriving a particular recipe we want to edit using the params which has the id
  def edit
    #@recipe = Recipe.find(params[:id])
    
    
  end
  
  # after the recipe is edited and submited we redirect user back to the edited 
  #recipe show page else  we render the edit form again
  def update
    #@recipe = Recipe.find(params[:id])
   
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
      
    else
      render :edit
      
    end
    
  end
  
  
  #this is our like action for our recipe conotroller that gives 
  #chef the ability to find and like recipe
  def like
    #@recipe = Recipe.find(params[:id])
    #to like a recipe chef must be logged in as current_user(befor_action) the befor action is to log in
    like = Like.create(like: params[:like], chef: current_user, recipe:@recipe)
    if like.valid?
      flash[:success] = "Your selection was successful"
      redirect_to :back
  else
    flash[:danger] = "You can only like/dislike a recipe once"
    
    redirect_to :back
    end
  
  end
  
  # here we are whitelisting or writting out the peramiters our app can permit to flow through
  # for creating a new recipe with our new form 
  private
  
  def recipe_params
    params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
  end
  
  #this set_recipe method for params(:id) will be executed before the edit, update and show actions
  def set_recipe
    @recipe = Recipe.find(params[:id])
    
  end
  
 # Here we want to make sure sure that chef can only edit the reicpes they create them self
  def require_same_user
    if current_user != @recipe.chef
        flash[:danger] = "You can only edit your own recipes"
        redirect_to recipes_path
    end
    
  end
  
  # requre_user action is defind in our application controller because is a method we will be 
 #using in all our controllers
 
 def require_user_like
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to  :back
   
    end
 end
  
  
  
end