class AddUuidToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uuid, :string, null: false
    add_index :users, :uuid, unique: true
  end
end
