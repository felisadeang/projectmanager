class Project < ActiveRecord::Base

  belongs_to :department
  belongs_to :manager, :class_name => 'User', :foreign_key => 'user_id'
  has_and_belongs_to_many :members, :join_table => :project_users , :class_name => 'User'
  has_many :tasks

  validates :name, :manager, presence: :true
  validates_date :deadline, :after => :today

  def self.search(search)
	  if search
	  	keyword = search.downcase
	    where('lower(name) LIKE ? OR lower(description) LIKE ?', "%#{keyword}%", "%#{keyword}%")
	  else
	    find(:all)
	  end
	end
end
