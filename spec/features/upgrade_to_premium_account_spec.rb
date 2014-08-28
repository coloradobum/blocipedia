require 'rails_helper'
require 'support/database_cleaner'

# As a user
# I want to upgrade to a premium user
# so I can create private wikis

feature 'upgrade to premium account' do

  scenario 'not authenticated' do
    visit root_path
    expect(page).to_not have_content("Upgrade to premium account")
  end

  scenario 'successfully', js: true do
    StripeMock.start_client
    user = FactoryGirl.create(:user, :confirmed)
    login_as(user, :scope => :user, :run_callbacks => false)

    visit wikis_path
    click_on 'Upgrade to premium account'
    fill_in "Card Number", with: '4242424242424242'
    fill_in "CVC", with: "123"
    fill_in "exp-month", with: "10"
    fill_in "exp-year", with: "2014"
    click_button "Charge my card"

    expect(page).to have_content("Thanks, you paid $5.00!")

    StripeMock.stop_client
  end
end
