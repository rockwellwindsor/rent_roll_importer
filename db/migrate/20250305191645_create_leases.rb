class CreateLeases < ActiveRecord::Migration[7.2]
  def change
    create_table :leases do |t|
      t.references :unit, null: false, foreign_key: true
      t.references :tenant, null: false, foreign_key: true
      t.date :move_in
      t.date :move_out

      t.timestamps
    end
  end
end
