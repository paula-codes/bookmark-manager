feature 'bookmarks page' do
  scenario 'viewing all available bookmarks' do
    visit '/bookmarks'
    expect(page).to have_content 'All Bookmarks:'
  end
end