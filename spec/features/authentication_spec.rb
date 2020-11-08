feature 'authentication' do
  scenario 'a user can sign in' do
    User.add(email: 'test@test.com', password: 'testpass')

    visit '/sessions/new'
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'testpass')
    click_button 'Sign in'

    expect(page).to have_content 'Welcome, test@test.com'

  end

  scenario 'a user sees an error if they mistype their email' do
    User.add(email: 'test@test.com', password: 'testpass')
    visit '/sessions/new'
    fill_in(:email, with: 'wrong@test.com')
    fill_in(:password, with: 'testpass')
    click_button 'Sign in'

    expect(page).not_to have_content 'Welcome, test@test.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user sees an error if they mistype their password' do
    User.add(email: 'test@test.com', password: 'testpass')
    visit '/sessions/new'
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'wrongpass')
    click_button 'Sign in'

    expect(page).not_to have_content 'Welcome, test@test.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user can sign out' do
    User.add(email: 'test@test.com', password: 'testpass')
    visit '/sessions/new'
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'testpass')
    click_button 'Sign in'

    click_button 'Sign out'

    expect(page).not_to have_content 'Welcome, test@test.com'
    expect(page).to have_content 'You have signed out.'
  end
end