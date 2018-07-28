class UsersController < ApplicationController
  before_action :authenticate_user! #Devise 提供的方法
  def tweets
  end

  def edit
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
