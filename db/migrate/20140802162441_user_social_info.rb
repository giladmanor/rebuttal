class UserSocialInfo < ActiveRecord::Migration
  def change
    add_column :users, :social_info, :text
  end
end
