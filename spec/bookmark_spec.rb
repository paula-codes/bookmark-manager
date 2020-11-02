require 'bookmark'

describe Bookmark do
  let(:subject) { Bookmark.new('test page') }

  describe '#self.all' do
    it "connects to the bookmarks table" do
      expect { Bookmark.all }.to_not raise_error
    end

    it "returns a list of all bookmarks" do
      populate
      expect(Bookmark.all).to eq ['http://www.makersacademy.com']
    end
  end
end
