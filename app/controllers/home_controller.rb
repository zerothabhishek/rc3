class HomeController < ApplicationController

  layout "demo"
  # show the welcome page if user isn't logged in,
  # redirect the user to resume index if she is logged in
  def index
    redirect_to resumes_path  if user_signed_in?
    # show welcome page - Render home/index.html.erb  
  end
  
  # create a demo resume for the (existing) demo user, 
  # and direct him to the resume edit page 
  def demo
    @resume = params[:r].blank? ? demo_user.resumes.create : demo_user.resumes.find(params[:r])
    @resume.style = @resume.style || default_style 
  end

end
