class AddMoveFirstToUser < ActiveRecord::Migration
  def change
    add_column :users, :move_first, :boolean, :default => false
  end
end
