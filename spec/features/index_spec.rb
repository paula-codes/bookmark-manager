feature 'index page' do
  scenario 'visiting index page' do
    visit '/'
    expect(page).to have_content("Hello World!")
  end
end