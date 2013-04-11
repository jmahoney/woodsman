class AddFieldsToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.text :intro
      t.string :slug
      t.string :html_title
      t.string :meta_description
      t.string :meta_tags
      t.index :slug
    end
  end
end
