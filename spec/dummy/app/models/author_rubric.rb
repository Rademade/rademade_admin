class AuthorRubric < ActiveRecord::Base

  belongs_to :author
  belongs_to :rubric

end