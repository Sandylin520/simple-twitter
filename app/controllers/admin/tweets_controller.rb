class Admin::TweetsController < Admin::BaseController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @tweets = Tweet.all.includes(:replies,:user)
    #使用rails include方法,一次將需要的資料查好
    #回傳所有tweet
    #tweets ,replies,user內容皆已在本次查詢,之後不會產生額外的查詢比數
  end

  def destroy
  end
end
