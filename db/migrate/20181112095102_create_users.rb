class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :avatar
      t.string :email
      t.string :encrypted_password
      t.integer :phone_number
      t.text :description
      t.string :certificate
      t.boolean :is_doctor
      t.integer :role

      t.timestamps
    end
  end
end
