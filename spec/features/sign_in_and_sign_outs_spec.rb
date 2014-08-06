require 'rails_helper'

feature 'Sign in and sign out', %q{
  As a User
  I want to sign in and sign out
  so I can manage and create wikis
} do
  
  scenario 'Sign in succesfully' do
    @user = FactoryGirl.create(:user)
    
    visit root_path
    click_on 'Sign in'
    fill_in 'Email', with: @user.email 
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
    
    expect(page).to have_content('Signed in successfully.')
  end
  
  scenario 'Sign out succesfully' do
    @user = FactoryGirl.create(:user)
    
    visit root_path
    click_on 'Sign in'
    fill_in 'Email', with: @user.email 
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

    click_on 'Sign out' 
    
    expect(page).to have_content('Signed out  successfully.')
  end
end
