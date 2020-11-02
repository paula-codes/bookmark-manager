require 'pg'

def connect_to_database
  con = PG.connect :dbname => 'bookmark_manager_test', :user => 'paula'
end

def populate
  con = connect_to_database
  con.exec "INSERT INTO bookmarks(url) VALUES('http://www.makersacademy.com')"
end