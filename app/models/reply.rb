class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :tweet,counter_cache: true #replies_count 有在tweet底下
end
