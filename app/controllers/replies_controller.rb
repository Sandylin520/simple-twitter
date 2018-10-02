class RepliesController < ApplicationController
  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = Reply.all
    @user = @tweet.user
    @reply = Reply.new
  end

  def create
  
  end

end
