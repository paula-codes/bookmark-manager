require 'pg'

class Bookmark
  def initialize(name)
    @name = name
  end

  def self.all
    database_name = 'bookmark_manager'
    
    if ENV['ENV'] == 'test'
      database_name = 'bookmark_manager_test'
    end
    
    urls = []
    con = PG.connect :dbname => database_name, :user => 'paula'
    data = con.exec "SELECT * FROM bookmarks"
    data.each do |row|
      urls << row['url']
    end
    urls
  end
end
