class Task < ActiveRecord::Base
  belongs_to :member, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :project
  belongs_to :department
 
  validates :name, :project_id, :member, presence: :true

  def self.search(id, search)
	  if search
	  	keyword = search.downcase
	    where('user_id = ? AND lower(name) LIKE ?',"#{id}" ,"%#{keyword}%")
	  else
	    find(:all)
	  end
	end
end
