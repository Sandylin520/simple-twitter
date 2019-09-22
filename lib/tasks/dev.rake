namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all  #model內已設定 user刪掉tweet會一併刪掉, tweet刪掉like.replies會一併刪掉
                      #所以不需要在去寫 Tweet.destroy_all, Like.destroy_all,  Reply.destroy_all
    # create 假資料
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{name}@example.com",
        password: "12345678",
        introduction: FFaker::Lorem::sentence(30),
        avatar: file
      )

      user.save!
    end
      puts "now you have #{User.count} users data"
      puts user.name
  end

  task fake_admin: :environment do
    file = File.open("#{Rails.root}/public/avatar/user1.jpg")
    # create admin種子資料
      user = User.create(
      email: "sandy@gmail.com",
      password: "12345678",
      name: "sandy",
      role: "admin",
      introduction: FFaker::Lorem::sentence(30),
      avatar: file
      )
      puts "admin has been generated"
      puts "#{user.name} is the admin"
  end

  task fake_tweet: :environment do   #model內已有設定user刪掉tweet會一併刪掉
       users = User.all
       users.each do |user| # user出發建立tweet假資料 可確保每個user均有tweet留言
         10.times do
            tweet_data = user.tweets.new(
            description: FFaker::Lorem::sentence(10)
            )
            tweet_data.save
         end
       end

       puts "each user has 10 tweets data"
       puts "now you have #{Tweet.count} tweets data"
  end

  task fake_user_following: :environment do # "user_id", "following_id
     User.all.each do |user|
        @users = User.where.not(id: user.id).shuffle  #先排除自己 #where.not確保不會自己加自己好友
        5.times do
         user.followships.create!(  #每個user建立5個followship
          following: @users.pop #取出＠users陣列中的最後一項作為following
         )
        end
     end
  puts "have created user_following"
  puts "each user successfully follow other 5 users"
  end

  #直接從like資料表出發
  task fake_likes: :environment do #建立一筆like資料需要有"user_id", "tweet_id"
    200.times do
      Like.create!(
        tweet_id: rand(Tweet.first.id..Tweet.last.id),
        user_id: rand(User.first.id..User.last.id)
       )
    end
    puts "now you have #{Like.count} likes data"
  end

  #直接從reply資料表出發
  task fake_replies: :environment do #t.text "comment", t.integer "tweet_id",t.integer "user_id"
      Tweet.all.each do |tweet|
        5.times do
         tweet.replies.create!(
           user_id: User.all.sample.id,
           comment: FFaker::Lorem::sentence(30)
        )
       end
      end
      puts "now you have #{Reply.count} replies"
      puts "each tweet has 5 replies"
  end
end
