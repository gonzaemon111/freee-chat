class RemoveUserToMessages < ActiveRecord::Migration[5.1]
  def change
    remove_reference :messages, :room, foreign_key: true
    add_column :messages, :room_id, :integer
  end
end
