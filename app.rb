require 'sinatra/base'
require './lib/bookmark'
require './database_connection_setup'
require 'uri'
require 'sinatra/flash'
require_relative './lib/comment'
require_relative './lib/tag'
require_relative './lib/bookmark_tag'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  set :session_secret, "here be dragons"
  register Sinatra::Flash
  
  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  get '/bookmarks/add' do
    erb :new_bookmarks
  end

  post '/bookmarks' do
    flash[:notice] = "You must submit a valid URL." unless Bookmark.add(url: params['url'], title: params[:title])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :edit_bookmarks
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'new_comments'
  end

  post '/bookmarks/:id/comments' do
    Comment.add(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params[:id]
    erb :'new_tags'
  end

  post '/bookmarks/:id/tags' do
    tag = Tag.add(content: params[:tag])
    BookmarkTag.add(bookmark_id: params[:id], tag_id: tag.id)
    redirect '/bookmarks'
  end

  get '/tags/:id/bookmarks' do
    @tag = Tag.find(id: params['id'])
    erb :'/tag_index'
  end



  run! if app_file == $0
end