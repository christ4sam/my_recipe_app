class ChefsController < ApplicationController
  #this set_chef method for params(:id) will be executed before the edit, update and show actions or code is run
  before_action :set_chef, only: [:edit, :update, :show]
  # here we want this require_same_user method befor_action to be executed or run first before 
  # edit and update actions to verify that the current logged in user owns the profile they want to edit or update
  # and that this actions can not be done through the browser as well
  before_action :require_same_user, only: [:edit, :update]
  
  
 def index
   @chefs = Chef.paginate(page: params[:page], per_page: 3)
   
 end

  
  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your account has been created succesfully"
      session[:chef_id] = @chef.id  #this line will log chef in authomatically after registration
      redirect_to recipes_path
      
      
    else
      render 'new'
    end
    
  end
  
  def edit
    #@chef = Chef.find(params[:id])
    
  end
  
  def update
    #@chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "Your profile has been updated succesfully"
      redirect_to chef_path(@chef)
      
    else
      render 'edit'
    end
  end
  
 def show
   #@chef = Chef.find(params[:id])
   @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3) #code paginates recipes in the chef show page
   
 end
 
 
  
  
  private 
  #here we are white listing the parameters we allowed in our forms
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
    
    #this set_chef method for params(:id) will be executed before the edit, update and show actions
    def set_chef
      @chef = Chef.find(params[:id])
      
    end
    
    #this method ensures that chef is able to edit only the recipe they have created and we will use it a befor_action
    #in this controller
    def require_same_user
      if current_user != @chef
        flash[:danger] = "You can only edit your own profile"
        redirect_to root_path
      end
    end
    
      
end
    
  
