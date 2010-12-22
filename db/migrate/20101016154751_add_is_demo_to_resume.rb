class AddIsDemoToResume < ActiveRecord::Migration
  def self.up
    add_column :resumes, :is_demo, :boolean
  end

  def self.down
    remove_column :resumes, :is_demo
  end
end
