require 'rails_helper'

# As a premium user
# I want to create private wikis
# So I can manage access to sensitive information

feature 'Add private wikis' do
 
  scenario 'Successfully' do
    user = FactoryGirl.create(:user, :confirmed2, :premium)

    sign_in_with(user.email, user.password)
    create_private_wiki('My private wiki', 'not for your eyes.')

    visit wikis_path
    expect(page).to have_content('My private wiki')
  end

  scenario 'As a non-premium user' do
    user = FactoryGirl.create(:user, :confirmed2)

    sign_in_with(user.email, user.password)
    visit wikis_path
    click_link "New Wiki"
    expect(page).to have_content("Upgrade to premium user to create private wikis")
  end
end
