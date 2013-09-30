get '/' do
  @user = Twitter.user
  @tweets = Twitter.user_timeline(@user.user_name)[0...10]
  erb :tweets
end

get '/:username' do

end
