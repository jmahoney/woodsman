class AddArchiveIntroToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.text :archive_intro
    end
  end
end
