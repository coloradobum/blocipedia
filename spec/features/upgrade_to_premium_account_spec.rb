require 'rails_helper'

# As a user
# I want to upgrade to a premium user
# so I can create private wikis

feature 'upgrade to premium account' do

  scenario 'checkbox without strip integration' do
    user = FactoryGirl.create(:user)
    user.confirmed_at = Time.now
    user.save

    visit root_path
    click_on 'Sign in'
    fill_in 'Email', with: user.email 
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    expect(page).to have_content("Upgrade to premium account")
  end
end
