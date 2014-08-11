class AddPremiumUserToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_premium_user, :boolean, :default => false
  end
end
