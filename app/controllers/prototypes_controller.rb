class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  # ログインしていなくても、詳細ページに遷移できる仕様にするためにexcept: [:index, :show, :create]としている
  before_action :authenticate_user!, except: [:index, :show]
  # ログアウト状態のユーザーであっても、トップページ・プロトタイプ詳細ページ・ユーザー詳細ページ・ユーザー新規登録ページ・ログインページには遷移できること
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  
  def index

    @prototypes = Prototype.includes(:user)
     # includesメソッドを使用することで、prototypesのすべてのデータを取得し、
      # prototypesテーブルに紐づくusersテーブルのデータを取得できる
      # includesメソッドを使用するとすべてのレコードを取得するため、allメソッドは省略可能
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


    def destroy
      prototype = Prototype.find(params[:id])
      prototype.destroy
      redirect_to root_path
    end
  
  def edit
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit, status: :unprocessable_entity
    end
    # 空の入力欄がある場合は、編集できずにそのページに留まること
    # 正しく編集できた場合は、詳細ページへ遷移する
  end



    def show
      @comment = Comment.new
      @comments = @prototype.comments.includes(:user)
    end

   
  

  private

  

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  
  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end
   # 特定のアクション内で「投稿者確認 (contributor_confirmation)」を行うためのメソッド
  # このメソッドが呼び出されると、ログインしているユーザーが特定のプロトタイプの投稿者であるかを確認し、
  # 投稿者でない場合はトップページにリダイレクトする動作を行う。
end


