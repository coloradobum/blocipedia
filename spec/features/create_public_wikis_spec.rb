require 'rails_helper'

feature 'add public wikis', %q{
  As a user
  I want to create public wikis
  So I can share them with everyone
} do

  scenario 'create a public wiki' do
    @user = FactoryGirl.create(:user)

    visit root_path
    click_on 'Sign in'
    fill_in 'Email', with: @user.email 
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

    click_on 'New wiki'
    fill_in 'wiki name', with: 'My first Wiki'
    click_button 'Create'

    expect(page).to have_content('My first Wiki')

  end
end
