class AssociatePostsWithImages < ActiveRecord::Migration
  def change
    add_column :posts, :image_id, :integer
    add_index :posts, :image_id
  end
end
