class FollowshipsController < ApplicationController
  # post followships
  #後面沒有帶:id參數,我們需要一個參數進來,所以必須在_path(following_id:xxx)裡面手動丟入參數=> followship_path(user),
  #create action裡面的 params[:following_id]就是由前端的_path裡的參數來的
  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save #如果通過 Model 驗證，成功儲存到資料庫裡，則導回同一頁，並顯示成功訊息
      flash[:notice] = "Successfully followed"
      redirect_back(fallback_location: root_path)

    else #如果驗證失敗，也導回同一頁，並將錯誤訊息顯示給使用者
      flash[:alert] = @followship.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

   # delete followships/:id
  def destroy
    @followship = current_user.followships.where(following_id: params[:id]).first
    @followship.destroy
    flash[:alert] = "Followship destroyed"
    redirect_back(fallback_location: root_path)
  end



end
