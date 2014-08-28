class Wiki < ActiveRecord::Base
  has_many :collaborations
  has_many :users, through: :collaborations

  belongs_to :user 
  
  scope :private_wikis, -> { where private: true }
  scope :owned_wikis, lambda { |user| where(:user_id => user.id) }
  scope :public_wikis, -> { where private: false }
  scope :show_wiki_details, lambda { |wiki_id| Wiki.where(id: wiki_id) }

  def self.is_wiki_collaborator(user, wiki_id)
    wiki_list = []
    user.collaborations.each { |wiki|  wiki_list << wiki.wiki_id }
    wiki_list.include? wiki_id 
  end
end
