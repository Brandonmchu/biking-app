class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :description
      t.string :title
      t.float :price
      t.string :url
      t.string :posted
      t.string :location
      t.string :category

      t.timestamps
    end
  end
end
