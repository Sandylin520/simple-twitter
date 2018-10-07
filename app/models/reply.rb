class Reply < ApplicationRecord
  validates_presence_of :comment #comment 值不可以為空白
  belongs_to :user
  belongs_to :tweet,counter_cache: true #replies_count 有在tweet底下
end
