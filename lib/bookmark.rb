require 'pg'
require 'database_connection'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id:, title:, url:)
    @id  = id
    @title = title
    @url = url
  end

  def self.all
    data = DatabaseConnection.query("SELECT * FROM bookmarks")
    data.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.add(url:, title:)
    if ENV['ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test', :user => 'paula'
    else
      con = PG.connect :dbname => 'bookmark_manager', :user => 'paula'
    end
  
    data = con.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, title, url;")
    Bookmark.new(id: data[0]['id'], title: data[0]['title'], url: data[0]['url'])
  end

  def self.delete(id:)
    if ENV['ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test', :user => 'paula'
    else
      con = PG.connect :dbname => 'bookmark_manager', :user => 'paula'
    end

    con.exec "DELETE FROM bookmarks WHERE id = #{id};"
  end

  def self.update(id:, url:, title:)
    if ENV['ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test', :user => 'paula'
    else
      con = PG.connect :dbname => 'bookmark_manager', :user => 'paula'
    end

    data = con.exec ("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = #{id} RETURNING id, url, title;")
    Bookmark.new(id: data[0]['id'], title: data[0]['title'], url: data[0]['url'])
  end

  def self.find(id:)
    if ENV['ENV'] == 'test'
      con = PG.connect :dbname => 'bookmark_manager_test', :user => 'paula'
    else
      con = PG.connect :dbname => 'bookmark_manager', :user => 'paula'
    end
    data = con.exec("SELECT * FROM bookmarks WHERE id = #{id};")
    Bookmark.new(id: data[0]['id'], title: data[0]['title'], url: data[0]['url'])
  end


end
