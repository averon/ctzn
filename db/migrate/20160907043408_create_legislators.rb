class CreateLegislators < ActiveRecord::Migration[5.0]
  def change
    create_table :legislators do |t|
      t.string :first_name
      t.string :last_name
      t.string :state
      t.string :chamber
      t.string :party
      t.string :bioguide_id

      t.timestamps
    end
  end
end
