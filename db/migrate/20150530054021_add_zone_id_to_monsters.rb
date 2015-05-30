class AddZoneIdToMonsters < ActiveRecord::Migration
  def change
    add_column :monsters, :zone_id, :integer
  end
end
