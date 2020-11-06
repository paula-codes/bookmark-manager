require 'database_helper'
require 'comment'
require 'bookmark'

describe Comment do

  describe '#self.add' do
    it 'adds a new comment' do
      bookmark = Bookmark.add(url: 'https://www.asos.com', title: 'ASOS')
      comment = Comment.add(text: 'Test comment', bookmark_id: bookmark.id)

      persisted_data = persisted_data(table: 'comments', id: comment.id)

      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'Test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end

  describe '.where' do
    it 'gets the relevant comments from the databse' do
      bookmark = Bookmark.add(url: 'https://www.asos.com', title: 'ASOS')
      Comment.add(text: 'Test comment', bookmark_id: bookmark.id)
      Comment.add(text: 'Second test comment', bookmark_id: bookmark.id)
  
      comments = Comment.where(bookmark_id: bookmark.id)
      comment = comments.first
      persisted_data = persisted_data(table: 'comments', id: comment.id)
  
      expect(comments.length).to eq 2
      expect(comment.id).to eq persisted_data.first['id']
      expect(comment.text).to eq 'Test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
end