require 'pry'
require_relative 'models/models'
require 'sinatra'
require 'sinatra/reloader'

configure do
  enable :sessions
  set logging: true 
end

helpers do
  def is_logged_in? 
    session[:username]
  end

  def user_name?
    if session[:username]
      @user = User.find_by_username(session[:username])
    else
      "Ooooppssss"
    end
  end
end

# The user urls
get '/' do
  @submit = Submit.all
  
  erb :index
end

get '/login' do
  erb :login
end

get '/new_user' do

  erb :new_user
end

post '/new_user' do
  @user = User.new
  @user.username = params[:username]
  @user.password = params[:password]

  if @user.save
    redirect '/'
  else
    "You should enter both fields"
  end
end

post '/login' do
  @user = User.find_by(username: params[:username])
  if params[:password] == @user.password
    session[:username] = params[:username]
    redirect '/'
  else
    "Username or Password incorrect"
  end
end

get '/logout' do
  session[:username] = nil 
  session[:password] = nil
  redirect '/'
end

# here is the submit urls
#
get '/submit' do
  erb :submit
end

post '/submit' do
  @submit = Submit.new
  @submit.link = params[:link]
  @submit.text = params[:text]
  user = User.find_by_username(is_logged_in?)
  @submit.user_id = user.id
  if @submit.save
    redirect '/'
  else
    redirect '/login'
  end
end

get '/vote/:id' do
  @submit = Submit.find(params[:id])

  @submit.increment!(:points)
  redirect '/'
end

private
def increment
  updates_attributes(:points => points + 1)
end
