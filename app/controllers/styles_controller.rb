class StylesController < ApplicationController
  #we need user to be logged in to be able to perform all the  actions in style excetp for the show action
  before_action :require_user, except: [:show]
  
  def new
    @style = Style.new
    
  end
  
  
  def show
    @style = Style.find(params[:id])
    @recipes = @style.recipes.paginate(page: params[:page], per_page: 4)
    
  end
  
  
  #To complete this action here first  make sure you white list the params you are permitting in the private method 
  def create
    @style = Style.new(style_params)
    if @style.save
      flash[:success] = "Style was created successfully"
      redirect_to recipes_path
      
    else
      render 'new'
    end
    
  end
  
  
  
  private 
  
  def style_params
    params.require(:style).permit(:name)
    
  end
  
end