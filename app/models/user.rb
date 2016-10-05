class User < ActiveRecord::Base
  belongs_to :department
  has_many :projects, dependent: :destroy
  has_many :projects_assigned, through: :project_users, source: :project
  has_many :project_users
  has_many :projects_table, :through => :project_users
  has_many :tasks

  has_secure_password

  validates :first_name, :last_name, :department_id, :manager, presence: :true
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  before_save do
    self.email.downcase!
  end
end
