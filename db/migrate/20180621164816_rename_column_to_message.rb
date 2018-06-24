class RenameColumnToMessage < ActiveRecord::Migration[5.1]
  def change
    remove_reference :messages, :users
    remove_reference :messages, :rooms
  end
end
