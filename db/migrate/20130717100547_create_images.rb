class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image
      t.string :title
      t.text :caption
      t.timestamps
    end
  end
end
