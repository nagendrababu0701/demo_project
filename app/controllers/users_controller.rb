class UsersController < ApplicationController
  skip_authorize_resource

  def dashboard
    @users = User.all
    @projects = Project.all
    status = ["new", "in progress", "done"]
    @projects_status = {}
    @user_status = {}
    status.each do |stat|
      @projects_status[stat] = {}
      @user_status[stat] = {}
      user_status_hash = @user_status[stat]
      @users.each do |user|
        user_status_hash[user.email] = user.todos.where("status= ?", stat).select("distinct(title)").collect{|o| o.title}
      end
      project_status_hash = @projects_status[stat]
      @projects.order(:id).each do |project|
        project_status_hash[project.title] = project.todos.where("status= ?", stat).select("distinct(title)").collect{|o| o.title}
      end
    end
    @count = {}
    @projects.each do |project|
      @count[project.title] = {}
      count_hash = @count[project.title]
      count_hash["new"] = project.todos.where("status= ?", "new").count
      count_hash["in progress"] = project.todos.where("status= ?", "in progress").count
      count_hash["done"] = project.todos.where("status= ?", "done").count
    end
  end

  def todo_status
    @todo = Todo.find_by_id(params[:id])
  end
  
  def update_status
    @todo = Todo.find_by_id(params[:id])
    respond_to do |format|
      if @todo.update(todo_params)
        done_status = Todo.where("status= ?", "done").count
        if done_status == Todo.all.length
          UserMailer.todo_status_updates(User.find_by_role("admin")).deliver
        end
        format.html { redirect_to root_path, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: todo_status_user(@todo) }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end
  def todo_params
    params.require(:todo).permit(:status)
  end

end
