class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
  	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
	def index
	end

	def show
		@user = User.find(params[:id])
		@manager = false
		if Project.find_by(user_id: params[:id])
			@manager = true
			@projects = User.find(params[:id]).projects
		else
			@projects = User.find(params[:id]).projects_assigned
		end
	end

	def edit
		@user = current_user
	end

	def destroy
		User.destroy(params[:id])
		redirect_to sessions_new_path
	end

	def new
		@departments = Department.all
	end

	def update
		@user = User.find(params[:id])
		User.where(id: params[:id]).limit(1).update_all(user_params)
		redirect_to user_path(@user.id)
	end

	def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
    	flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  private
  def user_params
  	params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end		
end
