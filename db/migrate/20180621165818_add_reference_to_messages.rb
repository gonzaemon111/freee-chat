class AddReferenceToMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :user, foreign_key: true, null: false
    add_reference :messages, :room, foreign_key: true, null: false
  end
end
