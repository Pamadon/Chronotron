class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :provider_id
      t.string :provider_hash
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
