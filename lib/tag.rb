require_relative 'database_connection'

class Tag
  attr_reader :id, :content

  def initialize(id:, content:)
    @id = id
    @content = content
  end

  def self.add(content:)
    data = DatabaseConnection.query("SELECT * FROM tags WHERE content = '#{content}';").first
    if !data
      data = DatabaseConnection.query("INSERT INTO tags (content) VALUES('#{content}') RETURNING id, content;").first
    end
    Tag.new(id: data['id'], content: data['content'])
  end

  def self.where(bookmark_id:)
    data = DatabaseConnection.query("SELECT id, content FROM bookmark_tags INNER JOIN tags ON tags.id = bookmark_tags.tag_id WHERE bookmark_tags.bookmark_id = '#{bookmark_id}';")
    data.map do |tag|
      Tag.new(id: tag['id'], content: tag['content'])
    end
  end

  def self.find(id:)
    data = DatabaseConnection.query("SELECT * FROM tags WHERE id = #{id};")
    Tag.new(id: data[0]['id'], content: data[0]['content'])
  end

  def bookmarks(bookmark_class = Bookmark)
    bookmark_class.where(tag_id: id)
  end
end