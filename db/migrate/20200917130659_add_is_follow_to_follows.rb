class AddIsFollowToFollows < ActiveRecord::Migration[6.0]
  def change
    add_column :follows, :is_follow, :boolean
  end
end
