require 'rails_helper'

# As a premium user
# I want to create private wikis
# So I can manage access to sensitive information

feature 'add private wikis' do
 
  scenario 'create a private wiki' do
    user = FactoryGirl.create(:user, :premium)

    sign_in_with(user.email, user.password)
    create_private_wiki('My private wiki', 'not for your eyes.')

    visit wikis_path
    expect(page).to have_content('My private wiki')
  end

  scenario 'non-logged in users cannot see private repos' do
    user = FactoryGirl.create(:user, :premium)

    sign_in_with(user.email, user.password)
    create_private_wiki('My private wiki', 'not for your eyes.')
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
