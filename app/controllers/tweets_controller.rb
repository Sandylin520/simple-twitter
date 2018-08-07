class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweets = Tweet.all # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.all
  end

  def create
    #產生新物件
    #寫入資料庫
  end

  def like
  end

  def unlike
  end

end
