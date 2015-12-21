
#All methods that will be used in all our controllers has to be defind in the application controller
# So all the methods we have here are methods that will be used in or call from any were in our application

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  # every methods create in the application_controller is avalible for use to all other controllers in our
  # application but they are not available to our views we specifiys them as helper methods below
  
  helper_method :current_user, :logged_in?  # makes this methods avaliable to our views
  
  
  #we want to restric certine permissions,
  # 1. only log in chefs can edit and create recipes 
  # 2. chef can only edit or delete recipes they created
  #here we will get the current user by finding the id of the user of that session 
  
  def current_user
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
    #memorization @current_user ||= will saves the current_user so that it doese not hit the database at any request
    
  end
  
  # to check if the current user is logged in or not
  def logged_in?
    !! current_user
  end
  
 # requre_user action is defind in our application controller because is a method we will be 
 #using in all our controllers
 
 def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to  recipes_path
   
    end
 end
    
end
