class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader #將avataruploader掛載到原先用於圖片路徑的avatar上

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  validates_uniqueness_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)

 #User 有許多likes
 #想要使用 @user.liked_tweets
  has_many :likes, dependent: :delete_all
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :replies, dependent: :restrict_with_error   # 如果 User 已經有了評論，就不允許刪除帳號（刪除時拋出 Error）
  has_many :tweets, dependent: :delete_all   #一次砍掉該user所有的tweets

  # has_many :方法命名，關聯資料表名稱，自己的主鍵，指向對方的外鍵
  has_many :followships , class_name: "Followship", primary_key: "id", foreign_key: "user_id", dependent: :destroy #找出該user的追蹤關係 (user model的id主鍵 指向 followships的user_id外鍵)
  has_many :followings, through: :followships  #找出追蹤關係裡面的following_id
  #has many 和belongs to是對接關係，因為rails 從followships裡面寫的belongs_to :following, class_name: "User"可得知following是來自user
  #所以在has many後面就可不必寫source: :user


  #user被很多人追蹤
  has_many :inverse_followships, class_name: "Followship", primary_key: "id", foreign_key: "following_id"#找出該user的被別人追蹤的關係((user model的id主鍵 指向followships的following_id外鍵)
  has_many :followers, through: :inverse_followships, source: :user
  #因為你的inverse_followships上面是寫user_id,前面用follower關聯方法,rails 無從判斷，故給source 讓他知道是要取user model上的對應的user_id資料(followers)
  #ex: 找出整列關係後 再找出找出所有追蹤following_id:4 的user(follower) 資料
  #:source 選項給 has_many :through 關聯指定來源關聯名稱。這個選項只有在來源關聯名稱無法自動推論出來的時候才使用。

  def admin?
    self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

  def update_likes_count(user)
    self.update(likes_count: self.tweets.sum(:likes_count))
    #self.tweets.sum(:likes_count)回傳like數量
    #self.update 將實際數量存入user likes_count此屬性中
  end

end
