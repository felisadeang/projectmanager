class UsersController < ApplicationController
	require 'date'
	before_action :require_login, except: [:index, :new, :create]
  	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	def index
	  if session[:user_id]
  	    redirect_to "/users/#{current_user.id}"
  	  end
	end

	def show
		@today = Time.now.strftime('%Y-%m-%d')
		@user = User.find(params[:id])
		@manager = false
		@tasks = Task.all

		if @user.manager
			@manager = true
			@projects = User.find(params[:id]).projects.order("priority, deadline")
		else
			@manager = false
			@member_tasks = Task.where(member: @user).order("priority, deadline")
			@projects = User.find(params[:id]).projects_assigned.order("priority, deadline")
		end
	end

	def edit
		@user = current_user
		@departments = Department.all.order('name')
	end

	def destroy
		User.destroy(params[:id])
		redirect_to sessions_new_path
	end

	def new
	  if session[:user_id]
	    redirect_to "/users/#{current_user.id}"
	  end
		@departments = Department.all
	end

	def create
    @user = User.new(user_params)
    if @user.valid?
			@user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

	def update
		@user = User.find(params[:id])
		@user.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], department: Department.find(params[:department]))
			if @user.errors.empty?
				redirect_to user_path(@user.id)
			else
				flash[:errors] = @user.errors.full_messages
				redirect_to :back
			end
	end

  private
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :name, :password, :password_confirmation, :department_id, :manager)
  end
end
