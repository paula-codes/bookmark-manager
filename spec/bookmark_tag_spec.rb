require 'bookmark_tag'

describe BookmarkTag do
  
  describe '#self.add' do
    it 'creates a link between a bookmark and a tag' do
      bookmark = Bookmark.add(title: 'ASOS', url: 'http://www.asos.com')
      tag = Tag.add(content: 'test tag')

      bookmark_tag = BookmarkTag.add(bookmark_id: bookmark.id, tag_id: tag.id)

      expect(bookmark_tag.tag_id).to eq tag.id
      expect(bookmark_tag.bookmark_id).to eq bookmark.id
    end
  end
end