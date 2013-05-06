class Post < ActiveRecord::Base
  attr_accessible :content, :rendered_content, :title
end
