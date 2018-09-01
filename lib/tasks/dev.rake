namespace :dev do
  # 請先執行 rails dev:fake_user，可以產生 20 個資料完整的 User 紀錄
  # 其他測試用的假資料請依需要自行撰寫
  task fake_user: :environment do
    User.destroy_all
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
    # create admin種子資料
      user = User.create(
      email: "sandy@gmail.com",
      password: "12345678",
      name: "sandy",
      role: "admin",
      introduction: FFaker::Lorem::sentence(30)
      )
      puts "admin has been generated"
      puts "#{user.name} is the admin"
  end

  task fake_tweet: :environment do

       users = User.all
       users.each do |user| # user出發建立tweet假資料 可確保每個user均有tweet留言
         rand(10).times do
            tweet_data = user.tweets.new(
            description: FFaker::Lorem::sentence(10)
            )
            tweet_data.save
         end
       end

       puts "now you have fake tweet data"
       puts "now you have #{Tweet.count} tweets data"
  end

end
