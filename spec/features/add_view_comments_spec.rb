feature 'adding and viewing comments' do
  feature 'a user can add and view a comment' do
    scenario 'a user can add a comment to a bookmark' do
      bookmark = Bookmark.add(url: 'http://www.asos.com', title: 'ASOS')
      visit '/bookmarks'
      first('.bookmark').click_button('Add comment')
      expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"
      fill_in 'comment', with: 'Test comment'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'Test comment'
    end
  end
end