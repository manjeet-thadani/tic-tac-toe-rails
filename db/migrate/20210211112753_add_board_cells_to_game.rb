class AddBoardCellsToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :cells, :string, array: true, default: []
  end
end
