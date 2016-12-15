class CreateSecrets < ActiveRecord::Migration[5.0]
  def change
    create_table :secrets do |t|
      t.string :secret
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
