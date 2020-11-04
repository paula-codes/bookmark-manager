require 'bookmark'
require 'database_helper'

describe Bookmark do

  describe '#self.all' do
    it "connects to the bookmarks table" do
      expect { Bookmark.all }.to_not raise_error
    end

    it "returns a list of all bookmarks" do
      con = PG.connect :dbname => 'bookmark_manager_test', :user => 'paula'
      
      bookmark = Bookmark.add(url: "http://www.makersacademy.com", title: "Makers Academy")
      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 1
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '#self.add' do
    it 'adds a new bookmark' do
      bookmark = Bookmark.add(url: 'http://www.asos.com', title: 'ASOS')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'ASOS'
      expect(bookmark.url).to eq 'http://www.asos.com'
    end
  end

  describe '#self.delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.add(url: 'http://www.asos.com', title: 'ASOS')
      Bookmark.delete(id: bookmark.id)
      expect(Bookmark.all.length).to eq 0
    end
  end
end