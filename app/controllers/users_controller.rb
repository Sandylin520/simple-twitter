class UsersController < ApplicationController
  before_action :authenticate_user! #Devise 提供的方法
  def tweets
     @user = User.find(params[:id])
     
  end

  def edit
     @user = User.find(params[:id])
      unless current_user == @user #若當前使用者不是這個tweet的擁有者
       redirect_to tweets_user_path(@user)  #導向只能針對此user 做Following的頁面
     end
  end

  def update
  end

  def followings
    @followings # 基於測試規格，必須講定變數名稱
  end

  def followers
    @followers # 基於測試規格，必須講定變數名稱
  end
end
