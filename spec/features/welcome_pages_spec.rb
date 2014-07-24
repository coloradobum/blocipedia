require 'rails_helper'

feature "WelcomePages", :type => :feature do
  scenario "see welcome message" do
    visit '/'
    expect(page).to have_content("Blocipedia: Social Markdown Wikis")
  end
end
