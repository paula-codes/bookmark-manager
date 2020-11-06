class Comment
  attr_reader :id, :text, :bookmark_id

  def initialize(id:, text:, bookmark_id:)
    @id = id
    @text = text
    @bookmark_id = bookmark_id
  end
 
 
  def self.add(bookmark_id:, text:)
    data = DatabaseConnection.query("INSERT INTO comments (bookmark_id, text) VALUES ('#{bookmark_id}','#{text}') RETURNING id, text, bookmark_id;")
    Comment.new(id: data[0]['id'], text: data[0]['text'], bookmark_id: data[0]['bookmark_id'])
  end

  def self.where(bookmark_id:)
    data = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{bookmark_id};")
    data.map do |comment|
      Comment.new(id: comment['id'], text: comment['text'], bookmark_id: comment['bookmark_id'])
    end
  end
end

