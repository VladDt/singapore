class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.string :status
      t.datetime :date_time

      t.timestamps
    end
  end
end
