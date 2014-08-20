require 'rails_helper'

feature 'Viewing private wikis' do

  scenario 'As guests' do
    user = FactoryGirl.create(:user, :premium)
    #TODO: create a factory for the private wiki

    sign_in_with(user.email, user.password)
    create_private_wiki('My private wiki', 'not for your eyes.')
    click_on 'Sign out'

    visit wikis_path
    expect(page).to_not have_content("My Shiny Private Wiki")
  end

  scenario 'Not being the owner' do
    wiki_owner = FactoryGirl.create(:user, :premium)
    non_wiki_owner = FactoryGirl.create(:user, :premium, email: 'nwo@g.com')

    sign_in_with(wiki_owner.email, wiki_owner.password)
    create_private_wiki('My private wiki', 'not for your eyes.')
    click_link 'Sign out'

    sign_in_with(non_wiki_owner.email, non_wiki_owner.password)
    visit wikis_path
    expect(page).to_not have_content('My private wiki') 
  end

  scenario 'As a collaborator' do
    pending
  end
end