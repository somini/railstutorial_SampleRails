class AddIndexToUsersNick < ActiveRecord::Migration
  def change
    add_index :users, :nick, unique: true
  end
end
