class CreateUnits < ActiveRecord::Migration[7.2]
  def change
    create_table :units do |t|
      t.string :unit_number
      t.integer :floor_plan

      t.timestamps
    end
  end
end
