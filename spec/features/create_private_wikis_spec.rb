require 'rails_helper'

# As a premium user
# I want to create private wikis
# So I can manage access to sensitive information

feature 'add private wikis' do
 
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

  scenario 'other logged in users cannot view private wiki' do
    wiki_owner = FactoryGirl.create(:user, :premium)
    non_wiki_owner = FactoryGirl.create(:user, :premium, email: 'nwo@g.com')

    sign_in_with(wiki_owner.email, wiki_owner.password)
    create_private_wiki('My private wiki', 'not for your eyes.')
    click_link 'Sign out'

    sign_in_with(non_wiki_owner.email, non_wiki_owner.password)
    visit wikis_path
    expect(page).to_not have_content('My private wiki')
    
  end
end
