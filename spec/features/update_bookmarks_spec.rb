feature 'Updating bookmarks' do
  scenario 'update a bookmark' do
    bookmark = Bookmark.add(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/bookmarks'
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')

    click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: 'http://www.pakersacademy.com')
    fill_in('title', with: 'Pakers Academy')
    click_button 'Submit'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Pakers Academy', href: 'http://www.pakersacademy.com')
  end
end