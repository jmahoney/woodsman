class AddTagsToPosts < ActiveRecord::Migration
  def change
    # change_table :posts do |t|
    #   t.string :tags, array: true
    # end
    execute "ALTER TABLE posts ADD tags VARCHAR(255)[]"
    execute "CREATE INDEX posts_tags_index ON posts USING gin(tags);"
  end
end
