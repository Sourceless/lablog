class Post < ActiveRecord::Base
  attr_accessible :content, :rendered_content, :title

  validates :title, presence:true, uniqueness:true
  validates :content, presence:true
  validates :rendered_content, presence:true
end
