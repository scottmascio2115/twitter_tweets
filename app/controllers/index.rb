get '/' do
  @user = Twitter.user
  @tweets = Twitter.user_timeline(@user.user_name)[0...10]
  erb :tweets
end

get '/:username' do
  @user = TwitterUser.find_by_user_name(params[:username])
  if @user.tweets_stale?
    @user.tweets.clear
    @user.fetch_tweets!
  end

  @tweets = @user.tweets
  erb :tweets
end
