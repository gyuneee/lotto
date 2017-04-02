class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|

      t.string  :board_numbers6
      t.string    :board_resultvalue

      t.timestamps null: false
    end
  end
end
