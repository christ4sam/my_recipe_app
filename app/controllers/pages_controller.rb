class PagesController < ApplicationController
  # This is the home page controller here we are saying if a chef log in dont show this home page redirect to all recipes page 
  def home
    redirect_to recipes_path if logged_in?
  
  end
end