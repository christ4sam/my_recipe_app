class PagesController < ApplicationController
  # This is the home page controller here we are saying if a chef log in dont show this page redirect to recipes page 
  def home
    redirect_to recipes_path if logged_in?
  
  end
end