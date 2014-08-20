class Wiki < ActiveRecord::Base
  has_many :collaborations
  has_many :users, through: :collaborations

  belongs_to :user 
  
  scope :private_wikis, lambda { |user| where(:user_id => user.id) }
  scope :public_wikis, -> { where private: false }
  scope :gikis, -> { where private: true }
end
