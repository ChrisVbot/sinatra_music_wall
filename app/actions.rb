# Homepage (Root path)
enable :sessions

# helper method to check for current user 

def current_user 
   #session's user_id = user's id
    @current_user = User.find_by(id: session[:user_id])
end


get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

get '/songs_by' do
  @author = params[:author]
  @songs = Song.where(author: params[:author])
  erb :'songs/artist'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url]
    )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

get '/users/login' do
  @user = User.new
  erb :'users/login'
end

post '/users' do
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

post '/login' do
  @user = User.where(username: params[:username]).where(password: params[:password])
    if @user.length > 0
      session[:user_id] = @user[0].id
      puts session[:user_id]
      # create session with @user's id
    else 
      # redirect // did you mean to create
    end
  redirect '/songs'
end

post '/logout' do
  session[:user_id] = nil
  redirect '/songs'
end
  









