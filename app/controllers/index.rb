get '/' do
  erb :index
end

get '/about' do

  erb :_about
end

get '/fishing_spot/:name/:lat/:long' do
  puts params.inspect
  @fisherman = Twitter.user_timeline(params[:name])

  @lat = params[:lat]
  @long = params[:long]
  puts @lat
  erb :fishing_spot
end

post '/post' do 
  if params[:city] == "" || params[:phrase] == ""

    redirect to '/'
  else
    puts params.inspect
    phrase = params[:phrase]
    tags = phrase.split(" ")
    @tweets = []
    @city = params[:city]
    @city = Geocoder.search(@city)
    lat = @city[0].latitude
    long = @city[0].longitude
    
    tags.each do |tag|
      Twitter.search(tag,:count => 100, :geocode => "#{lat},#{long},50mi").results.map do |status|

        @tweets << status 
      end
    end
   end
    erb :search
end



