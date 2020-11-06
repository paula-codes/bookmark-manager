require_relative 'database_connection'

class BookmarkTag
  attr_reader :bookmark_id, :tag_id


  def initialize(bookmark_id:, tag_id:)
    @bookmark_id = bookmark_id
    @tag_id = tag_id
  end

  def self.add(bookmark_id:, tag_id:)
    data = DatabaseConnection.query("INSERT INTO bookmark_tags(bookmark_id, tag_id) VALUES('#{bookmark_id}', '#{tag_id}') RETURNING bookmark_id, tag_id;")
    BookmarkTag.new(bookmark_id: data[0]['bookmark_id'], tag_id: data[0]['tag_id'])
  end
end
