class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet,counter_cache: true  #"likes_count"有在tweet底下
end
