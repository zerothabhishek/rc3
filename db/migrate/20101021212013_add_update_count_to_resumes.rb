class AddUpdateCountToResumes < ActiveRecord::Migration
  def self.up
    # update_count is used to save the no. of user attempts of updaing the resume through her interface.
    # This may/will be different from the actual save/update count, as failed saves are also counted, and 
    # console saves are not counted.
    add_column :resumes, :update_count, :integer, :default => 0
  end

  def self.down
    remove_column :resumes, :update_count
  end
end
