class Followship < ApplicationRecord
  validates :following_id, uniqueness: { scope: :user_id }
  belongs_to :user
  #belongs_to :user  , class_name: "User", foreign_key:"user_id", primary_key:"id"
  belongs_to :following, class_name: "User"
  #belongs_to :following, class_name: "User", foreign_key:"following_id", primary_key:"id"
  #雖然外鍵不是model_id 但方法名稱following 跟資料表欄位(following_id)一致,rails也認的出來
end
