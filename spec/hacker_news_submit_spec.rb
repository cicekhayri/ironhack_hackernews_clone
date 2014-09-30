require_relative "../hacker_news.rb"
require_relative "../models/models"
require_relative "spec_helper"

describe Submit do
  before do
    @submit = Submit.new
    @submit.link = "http://hoshilab.com"
    @submit.text = "Ruby on Rails web development"
  end

  it "should have http:// in the link" do
    @submit.link = "htt://hoshilab.com"
    @submit.valid?.should be_truthy
  end

  it "should not be empty link" do
    @submit.link = nil
    @submit.valid?.should be_falsy
  end

  it "should have a text for the link" do
    @submit.text = nil
    @submit.valid?.should be_falsy
  end

  it "should get '/' " do
    get '/'
    last_response.should be_ok
  end

  #it "should decrement the points" do

  #end
  
end
