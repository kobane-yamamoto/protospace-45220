class UsersController < ApplicationController
  def show
    @user = User.find(params[:id]) # ✅ URLの:idからユーザーを取得
    @prototypes = @user.prototypes # ✅ このユーザーの投稿一覧
  end
end