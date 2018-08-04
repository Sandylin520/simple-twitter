class Tweet < ApplicationRecord
  validates_length_of :description, maximum: 140
  belongs_to :user
  has_many :replies, dependent: :delete_all #刪除tweet，該tweet底下replies一併刪除
end
