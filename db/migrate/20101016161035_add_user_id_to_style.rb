class AddUserIdToStyle < ActiveRecord::Migration
  def self.up
    add_column :styles, :user_id, :integer
  end

  def self.down
    remove_column :styles, :user_id
  end
end
