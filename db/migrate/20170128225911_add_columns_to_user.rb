class AddColumnsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :ran, :string
    add_column :users, :running, :string
  end
end
