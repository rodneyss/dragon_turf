class AddInjuryToMonster < ActiveRecord::Migration
  def change
    add_column :monsters, :injury, :integer
    add_column :monsters, :max_health, :integer
  end
end
