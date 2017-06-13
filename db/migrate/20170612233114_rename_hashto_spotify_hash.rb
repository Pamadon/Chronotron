class RenameHashtoSpotifyHash < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :hash, :spotify_hash
  end
end
