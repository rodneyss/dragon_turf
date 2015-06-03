class AddWinnerToUser < ActiveRecord::Migration
  def change
    add_column :users, :winner, :boolean
  end
end
