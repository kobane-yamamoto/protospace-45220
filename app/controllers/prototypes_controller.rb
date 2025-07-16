class PrototypesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :move_to_root_path, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.order(created_at: :desc)
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @prototype = Prototype.new
  end

  def create
    # 投稿データ保存の処理
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: "更新に成功しました"
    else
    render :edit
    end
  end

  def destroy
  @prototype = Prototype.find(params[:id])
  @prototype.destroy
  redirect_to root_path, notice: "投稿を削除しました"
  end


  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_root_path
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user == @prototype.user
      redirect_to root_path, alert: "権限がありません"
    end
  end

end