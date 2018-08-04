class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :replies, dependent: :delete_all #刪除tweet，該tweet底下replies一併刪除

  #Tweet底下有有許多likes
  #想要使用@Tweet.liked_users的關聯方法
  has_many :likes, dependent: :delete_all
  has_many :liked_users, through: :likes, source: :user
end
vvv
