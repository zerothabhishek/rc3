class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :resumes
  end
end
