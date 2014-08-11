class Wiki < ActiveRecord::Base
  scope :public_wikis, -> { where private: false }
  scope :private_wikis, -> { where private: true }
end
