require 'rails_helper'

feature 'Creating a campaign' do
  let!(:user) { FactoryGirl.create :user, email: 'admin@test.xyz', password: 'password' }
  let!(:organization) { FactoryGirl.create(:organization) }

  before do
    user.add_role :admin
  end

  it 'creates a campaign' do
    visit new_user_session_path
    fill_in 'Email', with: 'admin@test.xyz'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')

    click_link 'Admin'
    click_link 'Campaigns'
    click_link 'Add new campaign'
    expect(page).to have_text('NEW CAMPAIGN')

    fill_in 'campaign_name', with: 'Test Campaign'
    fill_in 'campaign_description', with: 'lorem ipsum'
    attach_file 'campaign_logo', 'spec/asset_specs/images/example-logo.png'
    select '2018', from: 'campaign_donation_deadline_1i'
    select 'December', from: 'campaign_donation_deadline_2i'
    select '7', from: 'campaign_donation_deadline_3i'
    select '2018', from: 'campaign_reminder_date_1i'
    select 'December', from: 'campaign_reminder_date_2i'
    select '7', from: 'campaign_reminder_date_3i'
    click_button 'Create Campaign'
    expect(page).to have_text('Campaign created!')
  end
end
