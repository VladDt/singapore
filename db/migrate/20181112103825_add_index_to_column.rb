class AddIndexToColumn < ActiveRecord::Migration[5.1]
  def change
  	add_index :visits, :doctor_id
    add_index :visits, :patient_id
  end
end
