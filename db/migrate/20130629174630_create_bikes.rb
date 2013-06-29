class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.string :title
      t.string :description
      t.float :price
      t.string :url

      t.timestamps
    end
  end
end
