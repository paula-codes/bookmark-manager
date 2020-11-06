feature 'adding and viewing tags' do
  feature 'can add and view a tag' do
    scenario 'a tag is added to a bookmark' do
      bookmark = Bookmark.add(url: 'https://www.asos.com', title: 'ASOS')
      visit '/bookmarks'
      first('.bookmark').click_button 'Add tag'
      expect(current_path).to eq "/bookmarks/#{bookmark.id}/tags/new"

      fill_in 'tag', with: 'Test tag'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'Test tag'
    end
  end

  feature 'a user can filter bookmarks by tag' do
    scenario 'adding the same tag to multiple bookmarks then filtering by tag' do
      Bookmark.add(url: 'http://www.asos.com', title: 'ASOS')
      Bookmark.add(url: 'http://www.destroyallsoftware.com', title: 'Destroy All Software')
      Bookmark.add(url: 'http://www.google.com', title: 'Google')

      visit('/bookmarks')

      within page.find('.bookmark:nth-of-type(1)') do
        click_button 'Add tag'
      end
      fill_in 'tag', with: 'testing'
      click_button 'Submit'

      within page.find('.bookmark:nth-of-type(2)') do
        click_button 'Add tag'
      end
      fill_in 'tag', with: 'testing'
      click_button 'Submit'

      first('.bookmark').click_link 'testing'

      expect(page).to have_link 'ASOS', href: 'http://www.asos.com'
      expect(page).to have_link 'Destroy All Software',  href: 'http://www.destroyallsoftware.com'
      expect(page).not_to have_link 'Google', href: 'http://www.google.com'
    end
  end
end