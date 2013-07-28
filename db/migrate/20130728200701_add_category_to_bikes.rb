class AddCategoryToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :category, :string
  end
end
