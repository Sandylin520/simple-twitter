class RepliesController < ApplicationController
  def index
    @tweet = Tweet.find(params[:tweet_id])
    @replies = @tweet.replies
    @user = @tweet.user #for view中button 使用
    @reply = Reply.new  #for form_for 創建reply表單使用
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])#確認評論屬於哪一個tweet
    @reply = @tweet.replies.build(reply_params)#建立屬於 ＠tweet的評論,評論內容來自表單傳入的資料
    @reply.user = current_user
    if  @reply.save #將評論存入資料庫
      flash[:notice] = "Reply is successfully created"
      redirect_to tweet_replies_path(@tweet)#回到reply index頁面
    else
      flash[:alert] ="Reply cannot be blank"
      redirect_to tweet_replies_path(@tweet)
    end
  end


  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
end
