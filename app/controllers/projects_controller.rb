class ProjectsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def new
    @user = current_user
    @projects = Project.where(manager: current_user)
  end

  def create
  	@project = Project.new(project_params)
  	if @project.save
  		redirect_to "/users/#{current_user.id}"
  	else
  		flash[:errors] = @project.errors.full_messages
      	redirect_to :back
      end
    end

  def show
    @user = current_user
    @manager = false
    @project = Project.find(params[:id])
    
    if Project.find_by(user_id: current_user)
      @manager = true
    end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy if project.manager == current_user
    redirect_to "/users/#{current_user.id}"
  end
  
  def edit
    @project = Project.find(params[:id])
    @departments = Department.all
    @tasks = Task.where(project_id: params[:id], complete: false)
    @manager = false
    
    if Project.find_by(user_id: current_user)
      @manager = true
    end

  end

  def members
    render :json => { users: Department.find(params[:department_id]).members }
  end


  private
  def project_params
  	params.require(:project).permit(:name, :description, :user_id, :deadline, :department_id, :priority)
  end

end
