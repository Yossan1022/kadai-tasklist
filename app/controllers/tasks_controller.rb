#routes.rb で設定したルーティングに対応したアクションをこのファイルに追加する
class TasksController < ApplicationController
   before_action :require_user_logged_in
   before_action :correct_user, only: [:show,:edit,:update,:destroy]
 def update
   
  if @task.update(task_params)
   flash[:success] = 'Task は正常に更新されました'
   redirect_to @task
  else
   flash.now[:danger] = 'Task は更新されませんでした'
   render :edit
  end
 end
 def index
   @tasks = current_user.tasks.order(id: :desc)
 end

def new
  user = User.new
  @task = user.tasks.build
end
def create
  user = User.new
  @task = current_user.tasks.build(task_params)
    #@taskの保存が成功したら
 if @task.save
       #flash[:success] によって保存が成功したことをお知らせする
  flash[:success] = 'タスクを投稿しました。'
     #redirect_to はリンク先を指定して強制的に飛ばすメソッド。リンク先はトップページ。
  redirect_to root_url
 else
  flash.now[:danger] = 'タスクの投稿に失敗しました。'
     #render :new はtasks/new.html.erb を表示するということ
  render :new
 end
end
def destroy
  @task.destroy
  flash[:success] = 'タスクを削除しました。' 
  redirect_to root_url
end
  #privateはこのクラス内でのみ使用することを明示しています。def task_params は、アクションではなく単なる私用のメソッドとなります。
 private
  #def task_params がStrong Parameterで送信されてきたデータを精査（フィルタリング）している。今回の場合、 :content カラムだけが欲しい
def task_params
      #params.require(:task) でTaskモデルのフォームから得られるデータに関するものだと明示し、.permit(:content) で必要なカラムだけを選択しています。
  params.require(:task).permit(:content, :status)
end
#セキュリティ対策として、Strong Parameterが必要
def correct_user
  @task = current_user.tasks.find_by(id: params[:id])
  unless @task
  redirect_to root_url
  end
end
end