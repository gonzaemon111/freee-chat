class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.text :image
      t.references :users, null: false, index: true
      t.references :rooms, null: false, index: true

      t.timestamps
    end
  end
end
