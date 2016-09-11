class CreateLegislators < ActiveRecord::Migration[5.0]
  def change
    create_table :legislators, id: false do |t|
      t.string :bioguide_id, null: false
      t.string :first_name
      t.string :last_name
      t.string :state
      t.string :chamber
      t.string :party

      t.timestamps
    end

    add_index :legislators, :bioguide_id, unique: true
  end
end
