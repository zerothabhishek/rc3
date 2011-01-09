class Resume < ActiveRecord::Base
  belongs_to :user
  has_one :style_attachment, :dependent => :destroy
  has_one :style, :through => :style_attachment
  
  after_create :add_style
  
  def content_in_short
    return if content.blank?
    all_words = content.split(/\W/)
    first_ten = all_words.select{|w| !w.blank? }[0...9]
    content_in_short = first_ten.join(' ') + "..."
  end
  
  def add_style
    default_style = Style.find_by_title "default"
    #StyleAttachment.create!(:resume => self, :style => default_style)
    build_style_attachment(:style => default_style)
  end
  
  def fix_line_break_issue
    content.gsub!("\n", "  \n")
  end
  
end
