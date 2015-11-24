class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
    
  end
  
  def new
    
    @recipe = Recipe.new
  end
  # here create a new recipe and save, if you are able to save you will be redirected to list and a 
  # flash message that recipe was created 
  # of recipes but if cant save the create a new form again will be displayed again.
  # with a chef object to ensure every recipe is created by a registered chef so each 
  # recipe created is assigned to a chef
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(2)   #the chef object creating recipe
    
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
    @recipe = Recipe.find(params[:id])
    
    
  end
  
  # after the recipe is edited and submited we redirect user back to the edited 
  #recipe show page else  we render the edit form again
  def update
    @recipe = Recipe.find(params[:id])
   
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
      
    else
      render :edit
      
    end
    
  end
  
  
  def show 
    @recipe = Recipe.find(params[:id])
    
  end
  
  # here we are whitelisting or writting out the peramiters our app can permit to flow through
  # for creating a new recipe with our new form 
  private
  
  def recipe_params
    params.require(:recipe).permit(:name, :summary, :description, :picture)
  end
  
  
end