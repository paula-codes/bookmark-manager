feature 'bookmarks page' do
  scenario 'viewing all available bookmarks' do
    connect_to_database
    Bookmark.add(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/bookmarks'
    expect(page).to have_link('Makers Academy', href: 'http://www.makersacademy.com')
  end
end