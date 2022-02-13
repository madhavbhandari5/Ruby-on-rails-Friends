class HomeController < ApplicationController
  def index
    @my_index= "This is index page where we can see all the data which are fetched from the database...."
  end
  def about
    @about_me= "My name is Madhav Bhandari... I am from Kathmandu..."
  end
end
