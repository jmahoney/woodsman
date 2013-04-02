class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.datetime :published_at
      t.string :status, null: false, :default => 'draft'

      t.timestamps
    end
    
    add_index :posts, :status
  end
end
