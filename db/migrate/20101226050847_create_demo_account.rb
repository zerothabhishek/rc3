class CreateDemoAccount < ActiveRecord::Migration
  def self.up
    p "create demo user"
    demo_user = User.find_by_email "demo@rc.com"
    User.create(:email=>"demo@rc.com", :password => "demo123") if demo_user.blank?
  end

  def self.down
    p "destroy demo user"
    demo_user = User.find_by_email "demo@rc.com"
    unless demo_user.blank?
      demo_user.destroy
    end    
  end
end
