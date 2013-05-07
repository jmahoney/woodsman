class AddDateSlugToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.string :date_slug
      t.index :date_slug
    end
    #set the dates_slug by triggering a before_save
    Post.all.each{|p| p.save!}
    
  end
end
