module Features

  def create_public_wiki(title, body)
    create_wiki(title, body)
    click_button 'Save'
  end

  def create_private_wiki(title, body)
    create_wiki(title, body)
    check 'wiki_private'
    click_button 'Save'
  end

  private

  def create_wiki(title, body)
    visit wikis_path
    click_on 'New Wiki'
    fill_in 'Title', with: title 
    fill_in 'Body', with: body 
  end
end
