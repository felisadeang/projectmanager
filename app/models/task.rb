class Task < ActiveRecord::Base
  belongs_to :member, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :project
  belongs_to :department

  validates :name, :project_id, :member, presence: :true
end
