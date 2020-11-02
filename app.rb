require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  enable :sessions
  
  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @urls = Bookmark.all
    erb :bookmarks
  end

  run! if app_file == $0
end