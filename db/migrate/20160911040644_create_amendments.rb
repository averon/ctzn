class CreateAmendments < ActiveRecord::Migration[5.0]
  def change
    create_table :amendments, id: false do |t|
      t.string :amendment_id, null: false
      t.string :introduced_on
      t.string :last_action_at
      t.string :description
      t.string :purpose
      t.string :amends_bill_id, null: false
      t.string :sponsor_id, null: false

      t.timestamps
    end

    add_index :amendments, :amendment_id, unique: true
    add_index :amendments, :amends_bill_id
    add_index :amendments, :sponsor_id
  end
end
