class AddPostedToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :posted, :string
  end
end
