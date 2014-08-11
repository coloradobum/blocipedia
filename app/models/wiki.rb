class Wiki < ActiveRecord::Base
  scope :public_wikis, -> { where private: false }
end
