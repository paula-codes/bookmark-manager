feature 'Creating new bookmarks' do
  scenario 'add a new bookmark' do
    visit '/bookmarks/add'
    fill_in('url', with: 'http://www.asos.com')
    fill_in('title', with: 'ASOS')
    click_button 'Add'
    expect(page).to have_link('ASOS', href: 'http://www.asos.com')
  end

  scenario 'validating URL' do
    visit '/bookmarks/add'
    fill_in('url', with: 'not a real bookmark')
    click_button 'Add'
    expect(page).not_to have_content "not a real bookmark"
    expect(page).to have_content "You must submit a valid URL."
  end
end