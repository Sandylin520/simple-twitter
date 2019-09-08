class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @tweets = Tweet.order(created_at: :desc).page(params[:page]).per(10)
  end

  def destroy
    @tweet = Tweet.find(params[:id])#從前端回傳的:id
    @tweet.destroy
    redirect_to admin_tweets_path
  end
end
