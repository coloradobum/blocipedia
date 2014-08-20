require 'rails_helper'

# As a premium user
# I want to create private wikis
# So I can manage access to sensitive information

feature 'Add private wikis' do
 
  scenario 'Successfully' do
    user = FactoryGirl.create(:user, :premium)

    sign_in_with(user.email, user.password)
    create_private_wiki('My private wiki', 'not for your eyes.')

    visit wikis_path
    expect(page).to have_content('My private wiki')
  end

  scenario 'As a non-premium user' do
    pending
  end
end
