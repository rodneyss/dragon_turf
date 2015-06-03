class AddMoveFirstToUser < ActiveRecord::Migration
  def change
    add_column :users, :move_first, :boolean
  end
end
