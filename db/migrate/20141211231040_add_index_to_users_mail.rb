class AddIndexToUsersMail < ActiveRecord::Migration
  def change
    add_index :users, :mail
  end
end
