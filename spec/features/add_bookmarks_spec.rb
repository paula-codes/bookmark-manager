feature 'Creating new bookmarks' do
  scenario 'add a new bookmark' do
    visit '/bookmarks/add'
    fill_in('url', with: 'http://www.asos.com')
    fill_in('title', with: 'ASOS')
    click_button 'Add'
    expect(page).to have_link('ASOS', href: 'http://www.asos.com')
  end
end