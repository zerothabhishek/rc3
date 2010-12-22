class StyleAttachment < ActiveRecord::Base
  belongs_to :resume
  belongs_to :style
end
