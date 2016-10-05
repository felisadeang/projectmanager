class ProjectUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :project_user, :class_name => 'User'
  
end
