class Department < ActiveRecord::Base
	has_many :members, :class_name => 'User' #team members
	has_many :project_users, :through => :members
	has_many :projects, through: :project_users, source: :project
end
