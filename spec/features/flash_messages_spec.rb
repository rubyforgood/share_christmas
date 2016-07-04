feature 'flash message styling' do
  let!(:user) { FactoryGirl.create(:user, email: 'foo@foo.com', password: 'password') }

  before do
    visit new_user_session_path
  end

  scenario 'successful login' do
    fill_in 'Email', with: 'foo@foo.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_css '#flash-messages .alert-notice', text: 'Signed in successfully.'
  end

  scenario 'failed login' do
    fill_in 'Email', with: 'foo@foo.com'
    fill_in 'Password', with: 'p'
    click_button 'Log in'

    expect(page).to have_css '#flash-messages .alert-alert', text: 'Invalid Email or password.'
  end
end
