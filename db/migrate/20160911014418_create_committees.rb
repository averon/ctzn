class CreateCommittees < ActiveRecord::Migration[5.0]
  def change
    create_table :committees, id: false do |t|
      t.string :committee_id, null: false
      t.string :chamber
      t.string :name
      t.string :member_ids
      t.string :parent_committee_id

      t.timestamps
    end

    add_index :committees, :committee_id, unique: true
  end
end
