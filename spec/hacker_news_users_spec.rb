require_relative "../hacker_news"
require_relative "../models/models"
require_relative "spec_helper"

describe User do
  before do
    @user = User.new
    @user.username = "cicekhayri"
    @user.password = "secret99"
  end

  it "should not be empty username" do
    @user.username = ""
    @user.valid?.should be_falsy
  end

  it "should have a unique username" do
    @user.username != @user.username
    @user.valid?.should be_truthy
  end

  it "should not get valid if password is empty" do
    @user.password = nil
    @user.valid?.should be_falsy
  end

  it "expect the password to be between 8 and 20 characters" do
    @user.password = "jsj"
    @user.valid?.should be_falsy
  end

  it "should get '/'" do
    get '/'
    last_response.should be_ok
  end

  it "should get '/login'" do 
    get '/login'
    last_response.should be_ok
  end

  it "should get '/new_user'" do
    get '/new_user'
    last_response.should be_ok
  end

  it "should save the user" do
    post '/new_user', @user.attributes

  end 
end

