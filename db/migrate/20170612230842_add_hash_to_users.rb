class AddHashToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :hash, :text
  end
end
