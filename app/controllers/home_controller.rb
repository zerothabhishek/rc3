class HomeController < ApplicationController

  layout "demo"
  # show the welcome page if user isn't logged in,
  # redirect the user to resume index if she is logged in
  def index
    redirect_to resumes_path  if user_signed_in?
    # show welcome page - Render home/index.html.erb  
  end
  
  # create a demo resume for the (existing) admin user, 
  # and direct him to the resume edit page 
  def demo
    if params[:r].blank?
      r = admin.resumes.create(:content => "Copy-paste your resume here", :is_demo => true)
    else
      r = admin.resumes.find(params[:r])
    end
    redirect_to edit_resume_path(r)
  end

end
