require 'tag'
require 'bookmark'
require 'database_helper'
require 'bookmark_tag'

describe Tag do
  let(:bookmark_class) { double(:bookmark_class) }
  
  describe '#self.add' do
    context 'tag does not exist' do
      it 'adds a new tag' do
        tag = Tag.add(content: 'test tag')

        persisted_data = persisted_data(id: tag.id, table: 'tags')

        expect(tag.id).to eq persisted_data.first['id']
        expect(tag.content).to eq 'test tag'
      end
    end

    context 'tag already exists' do
      it 'returns the existing tag' do
        tag1 = Tag.add(content: 'test tag')
        tag2 = Tag.add(content: 'test tag')

        expect(tag2.id).to eq tag1.id
      end
    end
  end

  describe '#self.find' do
    it 'returns a tag with the given id' do
      tag = Tag.add(content: 'test tag')
      data = Tag.find(id: tag.id)

      expect(data.id).to eq tag.id
      expect(data.content).to eq tag.content
    end
  end

  describe '#bookmarks' do
    it 'calls .where on the bookmark class' do
      tag = Tag.add(content: 'test tag')
      expect(bookmark_class).to receive(:where).with(tag_id: tag.id)
      tag.bookmarks(bookmark_class)
    end
  end
  
  describe '#self.where' do
    it 'returns tags linked to the given bookmark id' do
      bookmark = Bookmark.add(url: 'https://www.asos.com', title: 'ASOS')
      tag1 = Tag.add(content: 'test tag 1')
      tag2 = Tag.add(content: 'test tag 2')
      BookmarkTag.add(bookmark_id: bookmark.id, tag_id: tag1.id)
      BookmarkTag.add(bookmark_id: bookmark.id, tag_id: tag2.id)

      tags = Tag.where(bookmark_id: bookmark.id)
      tag = tags.first

      expect(tags.length).to eq 2
      expect(tag.id).to eq tag1.id
      expect(tag.content).to eq tag1.content
    end
  end
  
end