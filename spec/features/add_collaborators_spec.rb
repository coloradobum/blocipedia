require 'rails_helper'

# As a user with a premium account
# I want to add collaborators to my private wikis
# so we can collaborate.

feature 'Add collaborators to private wikis' do

  scenario 'Successfully' do
    wiki_owner = FactoryGirl.create(:user, :confirmed, :premium)
    collaborator = FactoryGirl.create(:user, :confirmed, :premium, email: 'colab@example.net')

    sign_in_with(wiki_owner.email, wiki_owner.password)
    create_private_wiki('My Shiny Private Wiki', 'The best wiki ever.')
    click_link 'Edit'
    check 'colab@example.net'
    click_button 'Save'
    click_link 'Sign out'

    sign_in_with(collaborator.email, collaborator.password)
    visit wikis_path
    expect(page).to have_content('My Shiny Private Wiki')
  end

  scenario 'where collaborator is a non-premium user'  do
    wiki_owner = FactoryGirl.create(:user, :confirmed, :premium)
    collaborator = FactoryGirl.create(:user,:confirmed,  email: 'colab@example.net')

    sign_in_with(wiki_owner.email, wiki_owner.password)
    create_private_wiki('My Shiny Private Wiki', 'The best wiki ever.')
    click_link 'Edit'
    check 'colab@example.net'
    click_button 'Save'
    click_link 'Sign out'

    sign_in_with(collaborator.email, collaborator.password)
    visit wikis_path
    expect(page).to have_content('My Shiny Private Wiki')
  end

  scenario 'where empty selection is present' do
    wiki_owner = FactoryGirl.create(:user, :confirmed, :premium)
    collaborator = FactoryGirl.create(:user,:confirmed,  email: 'colab@example.net')

    sign_in_with(wiki_owner.email, wiki_owner.password)
    create_private_wiki('My Shiny Private Wiki', 'The best wiki ever.')
    click_link 'Edit'
    uncheck 'colab@example.net'
    click_button 'Save'
    click_link 'Sign out'

    sign_in_with(collaborator.email, collaborator.password)
    visit wikis_path
    expect(page).to_not have_content('My Shiny Private Wiki')
  end

end
