class CreateStyleAttachments < ActiveRecord::Migration
  def self.up
    create_table :style_attachments do |t|
      t.integer :style_id
      t.integer :resume_id

      t.timestamps
    end
  end

  def self.down
    drop_table :style_attachments
  end
end
