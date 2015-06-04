class AddInjuryToMonster < ActiveRecord::Migration
  def change
    add_column :monsters, :injury, :integer, :default => 0
    add_column :monsters, :max_health, :integer
  end
end
