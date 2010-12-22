class AddTitleToResumes < ActiveRecord::Migration
  def self.up
    add_column :resumes, :title, :string
  end

  def self.down
    remove_column :resumes, :title
  end
end