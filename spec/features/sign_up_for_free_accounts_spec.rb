require 'rails_helper'

feature 'Sign up for free account ',  %q{
  As a User
  I want sign up for a free account
  so that I can create wikis
} do

  scenario 'Sign up for an account' do
    visit root_path
    click_on 'Sign up'
    fill_in 'Username', with: 'joeblow'
    fill_in 'Email', with: 'joe@blow.com'
    fill_in 'Password', with: 'joespassword'
    fill_in 'Password confirmation', with: 'joespassword'
    click_button 'Sign up'
    expect(page).to have_content('Welcome joeblow')
  end

end
