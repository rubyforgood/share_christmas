describe 'Sign In' do
  let!(:user) { FactoryGirl.create :user, email: 'admin@test.xyz' }

  before do
    visit new_user_session_path
  end

  context 'successful sign in' do
    before do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    it 'displays' do
      expect(page).to have_text 'Signed in successfully.'
      expect(page).to have_link 'admin@test.xyz', href: edit_user_registration_path
      expect(page).to have_link 'Sign out', href: destroy_user_session_path
    end
  end

  context 'failed sign in' do
    before do
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'bad_password'
      click_button 'Log in'
    end

    it 'displays' do
      expect(page).to have_text 'Invalid Email or password.'
    end
  end
end
