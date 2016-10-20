class ProjectsController < ApplicationController
  require 'date'
  before_action :require_login

  def new
    @user = current_user
    @projects = Project.where(manager: current_user).order("priority, deadline")
    @tomorrow = Time.now.tomorrow.strftime('%Y-%m-%d')
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

  def search
    @projects = Project.search(params[:q]).all
    @departments = Department.all
  end

  def show
    @project = Project.find(params[:id])
    @departments = Department.all
    @manager = false
    @user = current_user
    @alltasks = Task.all
    @tasks = Task.where(project_id: params[:id]).order("priority, deadline")

    if Project.find_by(user_id: current_user)
      @manager = true
    end
  end

  def edit
    @tomorrow = Time.now.tomorrow.strftime('%Y-%m-%d')
    @project = Project.find(params[:id])
    @departments = Department.all
    @tasks = Task.where(project_id: params[:id], complete: false).order("priority, deadline")
    @manager = false

    if Project.find_by(user_id: current_user)
      @manager = true
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.update(project_params)
    redirect_to "/users/#{current_user.id}"
  end

  def members
    render :json => { users: Department.find(params[:department_id]).members }
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy if project.manager == current_user
    redirect_to "/users/#{current_user.id}"
  end

  private
  def project_params
  	params.require(:project).permit(:name, :description, :user_id, :deadline, :department_id, :priority)
  end

end
