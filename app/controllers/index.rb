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
 
  Twitter.search("to:#{handle} #{phrase}", :count => 1000000000, :result_type => "recent").results.map do |status|

    @tweets << status 
  end

  erb :search
end

post '/create_tweet' do 
  Twitter.update(params[:text])

  redirect to '/'
end

