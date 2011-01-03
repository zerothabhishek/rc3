class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def admin
    User.find_by_email "admin@rc.com"
  end
  
  def demo_user
    d = User.find_by_email "demo@rc.com"
  end
  
  # Returns the default style object
  # Currently set to the first style object
  def default_style
    Style.find 1
  end
  
  # Returns true if the request is a part of a demo - user is unauthenticated
  def demo?
    true unless user_signed_in?
  end
  helper_method :demo?
  
end
