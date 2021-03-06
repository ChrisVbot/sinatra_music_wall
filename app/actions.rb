# Homepage (Root path)


helpers do
#helper method to check for current user based on session ID. The pipes mean we don't have to re-query the database if the user is already logged in. Common way to initialize values from a false condition the first time you've gone through it. 
  def current_user
    @current_user = @current_user || User.find_by(id: session[:cookie_name])
  end
  
  #helper method to get the name of any given user
  def get_user_name(input)
    @get_user = User.where(id: input.user_id)
      if @get_user[0]
        @get_user[0].username
      else
        "Unknown"
      end
  end

end


get '/' do
  erb :index
end

#The 0- is so that is will be ordered correctly in descending order. Upvotes belong to songs(and users), so it is able to count the number of upvotes 
get '/songs/?' do
  @songs = Song.all.sort_by { |a| 0-a.upvotes.count }
  # binding.pry
  erb :'songs/index'
end

get '/songs/new/?' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id/?' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

get '/songs_by' do
  @author = params[:author]
  @songs = Song.where(author: params[:author])
  erb :'songs/artist'
end

post '/songs/?' do
  if 
    current_user
      @song = Song.new(
      title: params[:title],
      author: params[:author],
      url: params[:url],
      #just accessing the method and pulling the id from it. If no method currently exists, it will call the method here instead. 
      user_id: current_user.id
      )
    if @song.save
      redirect '/songs'
    else
      erb :'songs/new'
    end
  else
      flash[:notice] = "You must be logged in to submit songs."
      redirect '/songs/new'
  end
end

get '/users/?' do
  @users = User.all
  erb :'users/index'
end

get '/users/new/?' do
  @user = User.new
  erb :'users/new'
end

get '/users/login/?' do
  @user = User.new
  erb :'users/login'
end

post '/users/?' do
  @user = User.new(
    username: params[:username],
    password: params[:password]
    )
  if @user.save
    redirect '/songs'
  else
    erb :'users/new'
  end
end

post '/login/?' do
  @user = User.where(username: params[:username]).where(password: params[:password])
    #checks that user exists by verifying the length of items in array is > 0
    # binding.pry
    if @user.length > 0
      session[:cookie_name] = @user[0].id
      puts session[:cookie_name]
      flash[:notice] = "Thanks for logging in, #{@user[0].username}!"
      redirect '/songs'
    else 
      flash[:notice] = "Incorrect username or password! Please try again."
      redirect 'users/login'
    end
end

post '/logout' do
  session[:cookie_name] = nil
  redirect '/songs'
end

post '/upvote' do
    #Upvote table references both songs and users to keep track of upvotes. This allows users to only be able to vote once per song. 
    Upvote.create(user_id: session[:cookie_name], song_id: params[:song_id])
    flash[:notice] = "Thanks for voting!"
    redirect '/songs'
  # else
  #   flash[:notice] = "You must be logged in to upvote."
  # end
end
  
post '/review' do
  if current_user
    @review = Review.create(review: params[:review], user_id: session[:cookie_name], song_id: params[:song_id])
    if @review.save
      redirect '/songs/' + params[:song_id]
      flash[:notice] = "Thanks for the review!"
    else
      flash[:notice] = "Reviews can't be blank"
      redirect '/songs/' + params[:song_id]
    end
  end
end








