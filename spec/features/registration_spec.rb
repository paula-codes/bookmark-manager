feature 'Allows users to register' do
  scenario 'a user can sign up' do
    visit 'users/new'
    fill_in('email', with: 'test@test.com')
    fill_in('password', with: 'passtest')
    click_button 'Submit'

    expect(page).to have_content 'Welcome, test@test.com'
  end
end