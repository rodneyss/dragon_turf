class AddWinnerToMonster < ActiveRecord::Migration
  def change
    add_column :monsters, :winner, :boolean, :default => false
  end
end
