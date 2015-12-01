class LoginsController < ApplicationController
  
  # here logins form is not a model back form this form is handle by session this dosn,t have any data base table
  #when you login your user info get stored in the session and the section is stored inthe  browser cookees  
 # when you logout that section is destroyed
  
  def new
    
    
  end
  
  
  # here we are verifing the chef loging in details using find_by email then we authenticate the chef  
   #password, so if a chef exsist with that email and password is correct we will take the take the 
  # password and store it in our browser cookees then the chef will be loged in 
   #and login will be successful if not user will be send back to register form the new path
  def create
    chef = Chef.find_by(email: params[:email])
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id
        
      flash[:success] = "You are logged in successfuly"
      redirect_to recipes_path
      
    else
      flash.now[:danger] = " Your email address or password does not match"
      render 'new'
    
    
    end
    
  end
  
# here we are destrying the session and log user out when they click on the logout button
 
  def destroy
    session[:chef_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
    
  end
end