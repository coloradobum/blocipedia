class Wiki < ActiveRecord::Base
  belongs_to :user 
  
  scope :private_wikis, lambda { |user| where(:user_id => user.id) }
  scope :public_wikis, -> { where private: false }
  scope :gikis, -> { where private: true }
end
