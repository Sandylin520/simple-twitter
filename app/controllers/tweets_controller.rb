class TweetsController < ApplicationController
  before_action :authenticate_user!
  def index
    @tweets = Tweet.all # 基於測試規格，必須講定變數名稱，請用此變數中存放關注人數 Top 10 的使用者資料
    @users = User.all
    @tweet = Tweet.new #form_for表單需要有物件傳入 按鈕纔會顯示create
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)  #產生新物件
    if @tweet.save    # #寫入資料庫 如果@tweet.save回傳是true
      redirect_to tweets_path
    else  # 若false,回傳錯誤訊息
      flash[:alert]= @tweet.errors.full_messages.to_sentence
      redirect_to tweets_path
    end
  end

  def like
    @tweet = Tweet.find(params[:id])
    @tweet.likes.create!(user: current_user)
    redirect_to tweets_path
  end

  def unlike
    @tweet = Tweet.find(params[:id])
    like = Like.where(tweet:@tweet,user:current_user)
    like.destroy_all
    redirect_to tweets_path
  end


private


  def tweet_params
   params.require(:tweet).permit(:description)
  end

end
