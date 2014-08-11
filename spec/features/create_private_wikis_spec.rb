require 'rails_helper'

feature 'add public wikis', %q{
  As a user
  I want to be able to upgrade my account from a free plan to a paid plan
  So I can create private wikis 
} do
  
  scenario 'ability to upgrade free to premium account' do
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

  scenario 'create private wiki' do
    user = FactoryGirl.create(:user)
    user.confirmed_at = Time.now
    user.is_premium_user = true
    user.save

    visit root_path
    click_on 'Sign in'
    fill_in 'Email', with: user.email 
    fill_in 'Password', with: user.password
    click_button 'Sign in'

    click_on 'New Wiki'
    fill_in 'Title', with: "My Shiny Private Wiki"
    fill_in 'Body', with: "the best wiki ever"
    check 'wiki_private'
    click_on 'Save'

    click_on 'Sign out'

    visit wikis_path
    expect(page).to_not have_content("My Shiny Private Wiki")
  end
end
