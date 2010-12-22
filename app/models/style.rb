class Style < ActiveRecord::Base
  # Styles are the templates associated with the resume. 
  # Style associate to a resume through a style_attachment table, so -
  #   - a resume can have one style_attachment, that is one style
  #   - a style can have many style_attachments, that is, can be applied to many resumes
  # They contain the css and some meta data
  # Every user can create/edit/destroy her styles
  # User can also read/copy/use another user's styles
  # Styles are marked default, featured
  # Styles have to be rated/rated - based on usage, editorial 
  belongs_to :user
  has_many :style_attachments, :dependent => :destroy
  has_many :resumes, :through => :style_attachments
end
