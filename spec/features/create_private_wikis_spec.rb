require 'rails_helper'

# As a premium user
# I want to create private wikis
# So I can manage access to sensitive information 
feature 'Add private wikis' do

  scenario 'Successfully' do
    user = FactoryGirl.create(:user, :confirmed, :premium)

    sign_in_with(user.email, user.password)
    create_private_wiki('My private wiki', 'not for your eyes.')

    visit wikis_path
    expect(page).to have_content('My private wiki')
  end

  scenario 'As a non-premium user' do
    user = FactoryGirl.create(:user, :confirmed)

    sign_in_with(user.email, user.password)
    visit wikis_path
    click_link "New Wiki"
    expect(page).to have_content("Upgrade to premium user to create private wikis")
  end

  scenario 'non collaborator can not navigate to private wikis using url' do
    wiki_owner = FactoryGirl.create(:user, :confirmed, :premium)
    wiki_collaborator = FactoryGirl.create(:user, :confirmed, :premium, email: 'j@b.com')
    sign_in_with(wiki_owner.email, wiki_owner.password)
    create_private_wiki('private wiki', 'blah, blah, blah')
    sign_out
    
    sign_in_with(wiki_collaborator.email, wiki_collaborator.password)
    visit wiki_path(Wiki.last)
    
    expect(page).to_not have_content('private wiki')
  end

  scenario 'collaborator can see collaborated wiki' do
    wiki_owner = FactoryGirl.create(:user, :confirmed, :premium)
    wiki_collaborator = FactoryGirl.create(:user, :confirmed, :premium, email: 'j@b.com')
    sign_in_with(wiki_owner.email, wiki_owner.password)
    create_private_wiki('The birds and the Bees', 'blah, blah, blah')
    click_on "Edit"
    check wiki_collaborator.email
    click_button "Save"
    sign_out

    sign_in_with(wiki_collaborator.email, wiki_collaborator.password)
    visit wiki_path(Wiki.first)

    expect(page).to have_content("The birds and the Bees")
  end

  scenario 'collaborator can edit collaborated wiki' do
    wiki_owner = FactoryGirl.create(:user, :confirmed, :premium)
    wiki_collaborator = FactoryGirl.create(:user, :confirmed, :premium, email: 'j@b.com')
    sign_in_with(wiki_owner.email, wiki_owner.password)
    create_private_wiki("The birds and the Bees", "blah, blah, blah")
    click_on "Edit"
    check wiki_collaborator.email
    click_button "Save"
    sign_out

    sign_in_with(wiki_collaborator.email, wiki_collaborator.password)
    visit edit_wiki_path(Wiki.first)

    expect(page).to have_content("blah, blah, blah")
  end
end
