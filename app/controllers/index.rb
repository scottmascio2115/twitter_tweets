get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_by_user_name(params[:username])
  @user.tweets_stale?
  @tweets = @user.tweets
  erb :tweets
end

post '/username' do
  username = params[:name]
  @user = TwitterUser.find_or_create_by_user_name(username)
 

  redirect to "/#{username}"
end

get '/post' do 
  erb :search
end

post '/post' do 
  handle = params[:twitter_handle]
  phrase = params[:phrase]
  @tweets = []
  Twitter.search("to:#{handle} #{phrase}", :count => 100, :result_type => "recent").results.map do |status|
    @tweets << "#{status.from_user}: #{status.text}"
  end
  @tweets
  erb :search
end
