class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :key
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
