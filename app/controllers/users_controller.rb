class UsersController < ApplicationController
  before_action :authenticate_user! #Devise 提供的方法
  def tweets
     @user = User.find(params[:id])
     @tweets = @user.tweets  # for user_intro  view count div
     @followings = @user.followings # for user_intro  view count div
     @followers = @user.followers  # for user_intro  view count div
     @likes = @user.likes # for user_intro  view count div

     @usered_tweets = @user.tweets.order(created_at: :desc)
  end

  def edit
     @user = User.find(params[:id])
     unless current_user == @user #若當前使用者不是這個tweet的擁有者
       redirect_to tweets_user_path(@user)  #導向只能針對此user 做Following的頁面
     end
  end

  def update
     @user = User.find(params[:id])
     @user.update(user_params) #update會觸發save
     redirect_to edit_user_path(@user)
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings # return user's followings on right hand side

  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers  # return user's followings on right hand side

  end

  def likes
    @user = User.find(params[:id])
    @likes= @user.liked_tweets.order(created_at: :desc)# return user's liked_tweets s on right hand side

  end


  def user_params
    params.require(:user).permit(:name,:introduction,:avatar)
  end
end
