class TasksController < ApplicationController
   
  before_action only: [:destroy]

 def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
     flash[:success] = 'Task は正常に更新されました'
     redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
     render :edit
    end
 end
 
 def index
     @tasks = Task.all
 end
 def edit
     @task = Task.find(params[:id])
   
 end
def show
     @task = Task.find(params[:id])
end

def new
     user = User.last
     @task = user.tasks.build
end

def create
     user = User.last
     @task = user.tasks.build(task_params)
  if @task.save
     flash[:success] = 'タスクを投稿しました。'
     redirect_to root_url
  else
     flash.now[:danger] = 'タスクの投稿に失敗しました。'
     render 'tasks/new'
  end
end
  def destroy
     @task = Task.find(params[:id])
     @task.destroy
     flash[:success] = 'タスクを削除しました。' 
     redirect_to root_url
  end
  private
  def task_params
     params.require(:task).permit(:content, :status)
  end
end