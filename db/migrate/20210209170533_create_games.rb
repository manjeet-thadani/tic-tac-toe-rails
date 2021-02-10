class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :player_1_type
      t.string :player_2_type
      t.string :player_1_marker
      t.string :player_2_marker
      t.string :first_player

      t.timestamps
    end
  end
end
