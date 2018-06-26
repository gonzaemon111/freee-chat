class RemoveImageToMessages < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :image, :text
  end
end
