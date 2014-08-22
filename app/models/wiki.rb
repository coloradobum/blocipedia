class Wiki < ActiveRecord::Base
  has_many :collaborations
  has_many :users, through: :collaborations

  belongs_to :user 
  
  scope :private_wikis, -> { where private: true }
  #scope :owned_wikis, lambda { |user| where(:user_id => user.id) }
  scope :owned_wikis, lambda { |user| where(:user_id => user.id) }
  scope :public_wikis, -> { where private: false }
  #scope :collaboration_wikis, lambda { |wiki_id| where(:id => wiki_id ) }
  #scope :final_wikis, lambda { |wiki_list| find_all_by_id(wiki_list) } 
  #@collaboration_wikis = Wiki.find_all_by_id(collaboration_wikis_list)

  scope :jeff, lambda { |list| Wiki.where(id: list) }

end
